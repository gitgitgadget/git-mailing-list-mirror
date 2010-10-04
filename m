From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv6 01/16] test-lib: make test_expect_code a test command
Date: Mon, 4 Oct 2010 06:57:55 +0000
Message-ID: <AANLkTink3gPGVGXnO2j1cvfHShPG1Lq23eeY6m+7b1bK@mail.gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
	<1286136014-7728-2-git-send-email-newren@gmail.com>
	<7vfwwmdbgl.fsf@alter.siamese.dyndns.org>
	<AANLkTinVvmJMEDhPcxa_CiOL2_RsYBdo-JywXi2gKeYp@mail.gmail.com>
	<20101004035007.GB24884@burratino>
	<AANLkTi=7mrROAhFxNmF_cmU2OKKNuhsdTUVpHT+4Jg-Y@mail.gmail.com>
	<20101004040623.GC24884@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 08:58:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2ezr-0006pX-RU
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 08:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699Ab0JDG56 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 02:57:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46530 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682Ab0JDG55 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 02:57:57 -0400
Received: by iwn5 with SMTP id 5so6539569iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 23:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pDAHCI1/dWGuay8p/GPjTIWKsRd3GS/2+lOuRZbIceM=;
        b=mQx+BiY9bIXxV3Hrq61jEwVMkTH9rZgHjMfSEj5O79JIXfatPPMUEJrIA71BpUpWsn
         CcbpFYc4/4B93sOZs7WsZqKDN5PKKMqoPnR9yS/I5wGMK2vWohRXYzbKT4WTJLWsVacM
         Op9ycSdfFYamfZC1kiyY5tMX+vzxmIn5KN0As=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nbKx+EXiDggH5ysHBuOxCvt1HHIuaVUP+SFz4VKesDTpXCdKVS+lrz3PrK7ygmO/+4
         CFLuh2nFAyilNQVZWBkxJWuMXLF5IzIIhDTDZTQfC0P/Nou9mgXON8zwYZfPvgC1fsiX
         dhuJxkoKS0anY43xhn0/VlCKZeUHt1VnEct/E=
Received: by 10.231.182.201 with SMTP id cd9mr9723853ibb.21.1286175475845;
 Sun, 03 Oct 2010 23:57:55 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 3 Oct 2010 23:57:55 -0700 (PDT)
In-Reply-To: <20101004040623.GC24884@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157991>

On Mon, Oct 4, 2010 at 04:06, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Oct 4, 2010 at 03:50, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>
>>> I suspect the best thing would be to export TEST_DIRECTORY
>>> instead of including it inline in the script.
>>
>> We could do that, but then you couldn't cd to the trash directory an=
d
>> manually run the test without exporting the path to TEST_DIRECTORY
>> again.
>
> Okay, then how about:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0: ${TEST_DIRECTORY=3D$(cd ../.. && pwd)}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0. "$TEST_DIRECTORY"/test-lib.sh
>
> i.e., accepting TEST_DIRECTORY from the environment if and only
> if it is available?

Maybe, if someone thinks it's worthwhile.

On the other hand I just tested git in a path called /tmp/\\"\\/git/t
and found that every single one of our tests fail. So I think it would
be better to just leave this as it is (but maybe apply the <<\EOF
patch on top) and tackle the issue of the entire test suite breaking
under insane path names in some later patch.

I don't see the point spending time fixing it here if nothing else
works with crazy pathnames like these.
