From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv3 5/6] web--browse: use *www-browser if available
Date: Wed, 8 Dec 2010 08:38:11 +0100
Message-ID: <AANLkTimP+yLLH+arKeg-VHZ4OH5_JgKmdv90j3wGTVUk@mail.gmail.com>
References: <1291657790-3719-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291657790-3719-6-git-send-email-giuseppe.bilotta@gmail.com> <7vaakhnok7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 08:38:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQEbm-0005A4-Hl
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 08:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250Ab0LHHid convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 02:38:33 -0500
Received: from mail-iw0-f172.google.com ([209.85.214.172]:60540 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974Ab0LHHic convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 02:38:32 -0500
Received: by iwn40 with SMTP id 40so1187043iwn.3
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 23:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=xMYrE9hIQsV6j5WH51AP67vs/3zCowLFi5zepScV9JQ=;
        b=XW+kYzfdMPGoeU5fmgTU28ivSrD0vXLqaa5+xM7nVPTla+bSa95Kipyy/JV+Ryb1p5
         Rf0SfMMvtdCdBhKQQXt9omG88zVBehYRx21YeUNd23L0KfYFOyLGXkT/T7a7YTIa1KL8
         sXUOYQqLVESgav9LQht+oTeXG1SKuP0kjHvJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lQbbFqGi5HD6+MRzxODo345WWvbMEaJejokf1wBg3HrhR8XgEq2xABb9KnERJ5xYvS
         betH5jiThAlQzdEsqSeKilEWMMSw6MFRDAEKTbmFws+/ppHhJKgo+mTzDQiVgp5BijKf
         g8cGPwaR5gFwq36pSh1nsdhyeKmq3aYA8VmTM=
Received: by 10.231.36.5 with SMTP id r5mr2326652ibd.106.1291793911848; Tue,
 07 Dec 2010 23:38:31 -0800 (PST)
Received: by 10.231.39.3 with HTTP; Tue, 7 Dec 2010 23:38:11 -0800 (PST)
In-Reply-To: <7vaakhnok7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163173>

On Wed, Dec 8, 2010 at 12:36 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> + =A0 =A0 # if the linked executable doesn't match a browser name we=
 know about,
>> + =A0 =A0 # look at the version string
>> +
>> + =A0 =A0 # even though most browsers (and applications, in fact) wi=
ll show their
>> + =A0 =A0 # name and version on the first line of the --version outp=
ut, this is
>> + =A0 =A0 # not true in particular for the KDE apps (e.g. konqueror =
and kfmclient),
>> + =A0 =A0 # which display their name and version on the LAST line. S=
o we cannot
>> + =A0 =A0 # clip the version string at the first line when retrievin=
g it. Rather,
>> + =A0 =A0 # we keep it whole and then limit it when we know what we'=
re dealing with.
>
> I'd be more worried about the ones that do not understand --version a=
nd
> spawn a new window.

That's indeed a potential issue (although I _do_ wonder if there are
browsers that act like that; the only one I couldn't try, on Linux,
was dillo).

>> + =A0 =A0 verstring=3D"$("$testexe" --version 2> /dev/null)"
>> + =A0 =A0 browser=3D"$(echo "$verstring" | head -n 1 | cut -f1 -d' '=
 | tr A-Z a-z)"
>> + =A0 =A0 case "$browser" in
>> + =A0 =A0 =A0 =A0 =A0 =A0 mozilla)
>
> What was the first patch in this series about again ;-)?

Oh my! LOL. Ok, I can fix that 8-D

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 verstring=3D"$(echo "$vers=
tring" | head -n 1)"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 browser=3D"$(echo "$verstr=
ing" | cut -f2 -d' ' | tr A-Z a-z)"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
>> + =A0 =A0 =A0 =A0 =A0 =A0 google)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 verstring=3D"$(echo "$vers=
tring" | head -n 1)"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 browser=3D"google-chrome"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
>> + =A0 =A0 =A0 =A0 =A0 =A0 qt:)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # konqueror, kfmclient or =
other KDE app
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 verstring=3D"$(echo "$vers=
tring" | tail -n 1)"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 browser=3D"$(echo "$verstr=
ing" | cut -f1 -d:)"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
>> + =A0 =A0 =A0 =A0 =A0 =A0 *)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 verstring=3D"$(echo "$vers=
tring" | head -n 1)"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
>> +
>> + =A0 =A0 esac
>> + =A0 =A0 if valid_tool "$browser" ; then
>> + =A0 =A0 =A0 =A0 =A0 =A0 browser_path=3D"$i"
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0
>> + =A0 =A0 fi
>> +
>> + =A0 =A0 echo >&2 "$testexe (detected as $browser) is not a support=
ed browser, skipping"
>> + =A0 =A0 browser=3D""
>> + =A0 =A0 return 1
>> +}
>
> Sorry, but I simply do not think it is worth this ugliness to get sli=
ght
> customization between -new-tab, newTab, and nothingness.

I personally don't have a particular feeling for forcing the opening
in a new tab (and I might have over-engineered it, although it's not
really much more complex than the previous versions of this patchset,
it's just refactored.

If this requirement is relaxed, the patch becomes much simpler, and we
can include direct support for xdg-open, sensible-browser, htlmview &
so forth.

--=20
Giuseppe "Oblomov" Bilotta
