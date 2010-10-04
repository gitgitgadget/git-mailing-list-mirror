From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv6 01/16] test-lib: make test_expect_code a test command
Date: Mon, 4 Oct 2010 04:04:09 +0000
Message-ID: <AANLkTi=7mrROAhFxNmF_cmU2OKKNuhsdTUVpHT+4Jg-Y@mail.gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
	<1286136014-7728-2-git-send-email-newren@gmail.com>
	<7vfwwmdbgl.fsf@alter.siamese.dyndns.org>
	<AANLkTinVvmJMEDhPcxa_CiOL2_RsYBdo-JywXi2gKeYp@mail.gmail.com>
	<20101004035007.GB24884@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 06:04:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2cHl-0003jf-IY
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 06:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807Ab0JDEEL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 00:04:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54415 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab0JDEEK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 00:04:10 -0400
Received: by iwn5 with SMTP id 5so6399276iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 21:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gJfx4d/W4thxyTlDzZUXiyAMMun3mTPv1Rd5gVz5arg=;
        b=HLK+tTKnX/Lbtw6cxqUYkPLJp//2A1E0FPCIcJrxL6GwN11o99trautPTbyJzwLjia
         NRWimU47DY2cKdSWcPAmz/UhnOOd67kqOPQiiH6jtcY2Ecp5+hs674Is0689OqDQ+7bL
         paW7CkE33YwdlT4N5LKpgXEEn5xVjsQjOGw0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hWdilTwQeD4wK/jYZGJ/WLI/mlDTCMdxDX8rwlll0RLuWl2nLIZ9F0M6YEl1pBsr9K
         e88JcEgzrg+RvI5glO6UE0A24q9XbZaagC7v98zcxr3kFeKDhQ8wBp4BxWkTStyhHxKC
         5U+mQ3rdy2PA3TINa3GwEXy6hBkO01rVvn3EE=
Received: by 10.231.150.7 with SMTP id w7mr9494800ibv.14.1286165049101; Sun,
 03 Oct 2010 21:04:09 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 3 Oct 2010 21:04:09 -0700 (PDT)
In-Reply-To: <20101004035007.GB24884@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157971>

On Mon, Oct 4, 2010 at 03:50, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> With that the output of:
>>
>> =C2=A0 =C2=A0 $ rm -rfv trash*; ./t0000-basic.sh --debug; cat trash\
>> directory.t0000-basic/{passing-todo,failing-cleanup}/*.sh
>>
>> Is now (cut):
>>
>> =C2=A0 =C2=A0 # Point to the t/test-lib.sh, which isn't in ../ as us=
ual
>> =C2=A0 =C2=A0 TEST_DIRECTORY=3D"/home/avar/g/git/t"
>> =C2=A0 =C2=A0 . "$TEST_DIRECTORY"/test-lib.sh
>
> Edge case: what if the path to the git directory contains a "
> character (for example because someone is trying to ensure
> that git commands can cope with such a cwd)?
>
> I suspect the best thing would be to export TEST_DIRECTORY
> instead of including it inline in the script.

We could do that, but then you couldn't cd to the trash directory and
manually run the test without exporting the path to TEST_DIRECTORY
again.

Personally I care more about that sort of edge case that I actually
run into than someone testing Git under a crazy pathname.
