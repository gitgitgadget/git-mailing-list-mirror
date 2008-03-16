From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH] Fast forward strategies allow, never, and only
Date: Sat, 15 Mar 2008 22:44:48 -0800
Message-ID: <402c10cd0803152344h3fb6781fxd8e6375c8491f8a1@mail.gmail.com>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
	 <7vk5k9eqax.fsf@gitster.siamese.dyndns.org>
	 <402c10cd0803112246q4ec98018pe9a34b95e32cf1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 07:46:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JamdA-0000aX-67
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 07:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbYCPGou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 02:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbYCPGou
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 02:44:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:63243 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbYCPGot (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 02:44:49 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1110880fgb.17
        for <git@vger.kernel.org>; Sat, 15 Mar 2008 23:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=E+onsPtP8jjMW/2DBScd7FVzVkx+/ywYH8aCnVNThRo=;
        b=VFsoujeOiImo0def7lzQsNfEJ8BNeoTqTPORDxeFTt43gevCWdgxHWh9AnzYREIJyByGdAkbcNZAmx1oxiVPmBvdrwwnAcpVgRfCa22opVh3H4cAfNcENxD13uOGxPZAVu+7atNcXEIXC8DIf8F5S3/2QOh9Nzolex8jY/HgWTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OHCR8Laz7IFntWfOemcqFSSN+L5Y+qw080WfuVJ+R1BRyfJqICQ2dcnL3gu7OkiBK6dcq9tLU1uRIxy80Kt1LeQck2juCMqNRosASGhw3PpUR+yoHNgkxzKiTgFdviJplqxg9gHB+44W0syTkNimbtFvfQcz35AEUeuFNY+K+YU=
Received: by 10.82.127.14 with SMTP id z14mr32283998buc.3.1205649888092;
        Sat, 15 Mar 2008 23:44:48 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Sat, 15 Mar 2008 23:44:48 -0700 (PDT)
In-Reply-To: <402c10cd0803112246q4ec98018pe9a34b95e32cf1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77356>

On Tue, Mar 11, 2008 at 9:46 PM, Sverre Hvammen Johansen
<hvammen@gmail.com> wrote:
>  To me it makes sense that a squash oweride the ff options instead
>  of giving a error, but specifying a ff option after --squash is an error.

After some consideration I am convinced we should allow --squash
combined with any of the --ff options.  The same for --no-commit.
--squash combined with any of the --ff options means that the index
and the tree will only be updated if a merge without --squash would
have done the same.

That mean that t7600-merge.sh will break as follows:

* FAIL 19: combining --squash and --no-ff is refused

                test_must_fail git merge --squash --no-ff c1 &&
                test_must_fail git merge --no-ff --squash c1

-- 
Sverre Hvammen Johansen
