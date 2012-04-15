From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/5] completion: simplify __gitcomp_1
Date: Sun, 15 Apr 2012 07:45:43 +0300
Message-ID: <CAMP44s05KsZFAW=i7TvN0jDNPyFZ4OHkOTwVp2+04CR-jsz-nA@mail.gmail.com>
References: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
	<1334439784-6460-2-git-send-email-felipe.contreras@gmail.com>
	<87obqueyas.fsf@thomas.inf.ethz.ch>
	<CAMP44s3qXnONLh_=gO4_9DK2=bx0tLBTTAb4WenYh5k2QPQL-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Apr 15 06:46:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJHLz-0000F5-33
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 06:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505Ab2DOEpp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Apr 2012 00:45:45 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62406 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726Ab2DOEpo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Apr 2012 00:45:44 -0400
Received: by eaaq12 with SMTP id q12so1027336eaa.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 21:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9TpezO0EEdzEAKAKILVAce+/oGuyNPv5jvRWxLv4y1s=;
        b=Cx8ngy7xzB4TRkdReghWSMMuR94cOCPXhbdrDy0Lh3EXU6qX8MTfWSGahBBaxbBzK3
         MzPd0AZFU7hAR/iWoC5XhruwdT3WqvidngMXv9S+/LoSfxncQFcOC0Raw5oK1Gh2J1Lp
         4lS+0g06B6Bl8JYyeK2YgV6WM7rgH46GTdzp6sjmvuPTQqfMmemVSss6s5nIm0vRIPQJ
         f0XaNqftY4l6g9zAewSnA5OnO8ydhwZHgFuzRif4cjfIlaj82mpvQ6pZpTr9Oz5rY8vi
         wAmkWS65UkTbycoguAgEIyh8CsCKkEnaCPP4njjnDhtHY5AjYdFkIaV1e1HZGA6UGJzD
         ZBBg==
Received: by 10.14.96.6 with SMTP id q6mr983593eef.6.1334465143466; Sat, 14
 Apr 2012 21:45:43 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Sat, 14 Apr 2012 21:45:43 -0700 (PDT)
In-Reply-To: <CAMP44s3qXnONLh_=gO4_9DK2=bx0tLBTTAb4WenYh5k2QPQL-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195545>

On Sun, Apr 15, 2012 at 1:54 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sun, Apr 15, 2012 at 1:36 AM, Thomas Rast <trast@inf.ethz.ch> wrot=
e:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> =C2=A0# __gitcomp_1 requires 2 arguments
>>> =C2=A0__gitcomp_1 ()
>>> =C2=A0{
>>> - =C2=A0 =C2=A0 local c IFS=3D' '$'\t'$'\n'
>>> + =C2=A0 =C2=A0 local c s IFS=3D' '$'\t'$'\n'
>>> =C2=A0 =C2=A0 =C2=A0 for c in $1; do
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case "$c$2" in
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --*=3D*) printf %s$'\n'=
 "$c$2" ;;
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *.) =C2=A0 =C2=A0printf=
 %s$'\n' "$c$2" ;;
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *) =C2=A0 =C2=A0 printf=
 %s$'\n' "$c$2 " ;;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --*=3D* | *.) s=3D"" ;;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *) =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0s=3D" " ;;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 esac
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "$c$2$s"
>>> =C2=A0 =C2=A0 =C2=A0 done
>>> =C2=A0}
>>
>> Sorry for not noticing earlier, but...
>>
>> I did a double take at the change to 'echo'. =C2=A0I'm guessing from=
 the
>> patch that $c$2$s is never just '-e' or some other option taken by t=
he
>> bash version[1] of echo. =C2=A0But can you be sure? =C2=A0Do you kno=
w off hand
>> whether '-nbogus' complains, treats the -n as usual and prints 'bogu=
s',
>> or echoes '-nbogus'[2]? =C2=A0Are you sure future bash versions won'=
t break
>> this?
>
> That doesn't make any sense to me. If you want that, you should do
> 'eval "echo $foo"', and even if you do 'eval "echo \"$foo\""', that
> would be avoided.

Actually, after a private discussion with Thomas, I realized that's on
zsh, on bash it doesn't work as I expected, plus, in both 'echo "-n"'
does the unexpected thing (to me).

So, it should be, maybe 'print "%s\n" "$c$2$s"', or 'print "%s$s\n" "$c=
$2"'.

However, I would like to simplify it even more:

__gitcomp_1 ()
{
	local c w s IFS=3D' '$'\t'$'\n'
	for c in $1; do
		w=3D"$c$2"
		case "$w" in
		--*=3D*|*.) s=3D"" ;;
		*)        s=3D" " ;;
		esac
		printf "%s$s\n" "$w"
	done
}

--=20
=46elipe Contreras
