From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 3/3] bisect: check for mandatory argument of 'bisect replay'
Date: Thu, 14 Oct 2010 09:55:53 +0200
Message-ID: <AANLkTi=HCHy0q4atzVYUGO0hQ3FBigZcFDsFLv9iZ=h-@mail.gmail.com>
References: <1286747338-8521-1-git-send-email-szeder@ira.uka.de>
	<1286747338-8521-3-git-send-email-szeder@ira.uka.de>
	<201010120435.11903.chriscool@tuxfamily.org>
	<201010120456.35411.chriscool@tuxfamily.org>
	<7viq16m0tk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 09:56:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6IfS-0003tw-7d
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 09:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817Ab0JNHz4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 03:55:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57001 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab0JNHzz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 03:55:55 -0400
Received: by wyb28 with SMTP id 28so1848140wyb.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 00:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d9yWDtwqe+jHccsq7TWlm94TeNWEbYfnYVA51TcUWkA=;
        b=iruKXKAbWnRHSGhf5mt7LCxrRdKyACM3MipCLWbsD46OldhQShgHge8db8R+FfanS3
         6IWlmA5JP16CqvBkToMddh3Mkl0zb/vWBYHQo5rYxQOyE6vZysz1amD5TQqlTLPbmhSu
         50egiucS1Edoz4EIVB7OUH7a00WcWAgtqGiJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AXpSULEV0OKyGrv6masQ6Ci7iLNmnopJAQYYz0l4Q4u++T09s08egg3ldOPeuEEgSr
         6duQAB0VWkoKQM9+9TtrT2WMYtXO++8Z/6GxTW2Wm+U+eRs/R9zKx+RXZfIE90oO/Rlf
         zvxVcIZp186WyaYmSPwyA7duGhH0vrk+X8LdQ=
Received: by 10.227.132.211 with SMTP id c19mr9496143wbt.226.1287042954001;
 Thu, 14 Oct 2010 00:55:54 -0700 (PDT)
Received: by 10.216.35.199 with HTTP; Thu, 14 Oct 2010 00:55:53 -0700 (PDT)
In-Reply-To: <7viq16m0tk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159027>

On Wed, Oct 13, 2010 at 7:58 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>>> > =A0bisect_replay () {
>>> >
>>> > + =A0test "$#" -eq 1 || die "No logfile given"
>>> >
>>> > =A0 =A0test -r "$1" || die "cannot read $1 for replaying"
>>> > =A0 =A0bisect_reset
>>> > =A0 =A0while read git bisect command rev
>>>
>>> While at it perhaps you could do something like:
>>>
>>> bisect_replay () {
>>> + =A0 =A0test "$#" -lt 1 || die "No logfile given"
>>> + =A0 =A0test "$#" -gt 1 || die "Too many argument. Please give onl=
y one logfile."
>>> =A0 =A0 =A0test -r "$1" || die "cannot read $1 for replaying"
>>> =A0 =A0 =A0bisect_reset
>>> =A0 =A0 =A0while read git bisect command rev
>>
>> I mean:
>>
>> bisect_replay () {
>> + =A0 =A0 test "$#" -lt 1 && die "No logfile given"
>> + =A0 =A0 test "$#" -gt 1 && die "Too many argument. Please give onl=
y one logfile."
>> =A0 =A0 =A0 test -r "$1" || die "cannot read $1 for replaying"
>> =A0 =A0 =A0 bisect_reset
>> =A0 =A0 =A0 while read git bisect command rev
>
> That suggests that the original patch is buggy as well, in that it sa=
ys
> "No logfile given" when it gets two.
>
> How about checking with 1 and saying "Give me only one logfile" and b=
e
> done with it?

Yeah or: "Give me exactly one logfile as argument"

Best regards,
Christian.
