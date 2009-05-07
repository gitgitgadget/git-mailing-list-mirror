From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: shell compatibility issues with SunOS 5.10
Date: Thu, 7 May 2009 11:38:16 +1000
Message-ID: <fcaeb9bf0905061838l1e2079f9rd248b40c87b00388@mail.gmail.com>
References: <20090506055913.GA9701@dektop> <7vljpaycwg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 03:38:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1sZS-0000Pd-2g
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 03:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827AbZEGBih convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2009 21:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754666AbZEGBih
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 21:38:37 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:64534 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbZEGBig convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 21:38:36 -0400
Received: by yx-out-2324.google.com with SMTP id 3so290065yxj.1
        for <git@vger.kernel.org>; Wed, 06 May 2009 18:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=QDdzOsnJsq85BSsbsCEyrMeXZLmi0mR1yya7mTD78CU=;
        b=rQxWsakuSpRbUvkds5Yq4neVkTevMjowp8Ys523f4ZDTxQ83XqYLMiaf/OCYBi2/IE
         o+e2J9KwcI/2Wj/nXvmZ1JwDS1EoL/0nEEJw2zUueUF9mKMluwQ66x3oIyFDIY0AKBqa
         WT4KiDR4K+k20kME5jPIv1DN4UwSL6uL0kcMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=r+ePDyDXlSMj5x/0iH7n9nSLhRyO+T608MWG8SKvmKzg50cIVmE2oRd5b6o8QzuYTv
         YgM7tvUdhyOvqsH/FBZH2ryFWYDzQwLm56tH8s7GNgN5hptGMllOgKkKumB3Wix8KGpL
         s3h6z0rZ/5Jxy3s5bsoozMuBhspOQGfKusppM=
Received: by 10.100.132.14 with SMTP id f14mr4213059and.79.1241660316444; Wed, 
	06 May 2009 18:38:36 -0700 (PDT)
In-Reply-To: <7vljpaycwg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118418>

On Wed, May 6, 2009 at 4:16 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
>> index e2aa254..9a916d3 100755
>> --- a/t/t5300-pack-object.sh
>> +++ b/t/t5300-pack-object.sh
>> @@ -315,7 +315,7 @@ test_expect_success 'unpacking with --strict' '
>> =C2=A0 =C2=A0 =C2=A0 head -n 10 LIST | git update-index --index-info=
 &&
>> =C2=A0 =C2=A0 =C2=A0 LI=3D$(git write-tree) &&
>> =C2=A0 =C2=A0 =C2=A0 rm -f .git/index &&
>> - =C2=A0 =C2=A0 tail -n 10 LIST | git update-index --index-info &&
>> + =C2=A0 =C2=A0 tail -10 LIST | git update-index --index-info &&
>
> I do not know why your "head" apparently accepts -n (see the context)=
 but
> not your "tail"; as POSIX frowns upon head/tail -$number, this one is=
 a
> regression.
>

I digged back in history and found Jeff's b4ce54fc, so my approach is
wrong too. Does it have to be exactly ten last lines? If it's just one
or two lines, then sed -ne '$p' can be used.
--=20
Duy
