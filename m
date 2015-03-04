From: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: zip files created with git archive flags text files as binaries
Date: Wed, 04 Mar 2015 22:13:17 +0100
Message-ID: <54F7756D.6080907@web.de>
References: <12g5ss8uqwflv.dlg@nililand.de> <54EB7FE4.7070804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: luatex@nililand.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 22:15:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTGcw-0002Rp-IR
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 22:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbbCDVOI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2015 16:14:08 -0500
Received: from mout.web.de ([212.227.17.12]:61247 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752410AbbCDVN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 16:13:28 -0500
Received: from [192.168.178.27] ([79.250.186.137]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MeSOZ-1Y7SjB06U3-00QDYf; Wed, 04 Mar 2015 22:13:26
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <54EB7FE4.7070804@web.de>
X-Provags-ID: V03:K0:arO7WPmiDcUblr7hpeFSEqHxXZlRWUMPSkOFyOz/ctEZHqaDpJ1
 KyCTLsMs/9zfW5Sv7DM7Lor2DBLA+ehfubNRv9ypVLDK+bVG7a00vVZnIvXVtbGtA3QgLNU
 Tu8Xj8nO3abW3lrCV7OHQunp6P57BaOi6vy1kNHw6U6bR98+1wd0Rsv+XKOU8cJuzTv1wTQ
 dtHF/eAvRf3/zauXdsHrQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264778>

Am 23.02.2015 um 20:30 schrieb Ren=E9 Scharfe:
> Am 23.02.2015 um 14:58 schrieb Ulrike Fischer:
>> The zip contained four text files and a pdf.
>>
>> The CTAN maintainers informed me that all files in the zip are
>> flagged as binaries and this makes it difficult for them to process
>> them further (they want to correct line feeds of the text files:
>> http://mirror.ctan.org/tex-archive/help/ctan/CTAN-upload-addendum.ht=
ml#crlf)

By the way, a workaround for CTAN could be to extract the files using=20
unzip and zip them again using Info-ZIP zip (one of the "good zip=20
programs" mentioned on that website).  The result will be a ZIP file=20
with text files flagged appropriately.  Just saying.

>> Would it be possible to correct the zip-backend so that it flags
>> text files correctly? Or alternativly could one configure git
>> archive to use another zip programm?
>
> We would have to detect the line ending format (DOS, Unix, Macintosh,
> etc.) of each file, then set the attribute "t" (text) and the host
> system.  The detection would slow down archive creation a bit and the
> resulting files would be different, of course, so this feature should
> only be enabled by a new command line option.  I'll take a look.

Actually its easier than that.  unzip -a (with end-of-line conversion)=20
doesn't care for the actual format, it simply converts all occurrences=20
of CR, CRLF and LF to the appropriate newline chars for the platform it=
=20
is running on if the text flag is set.  Files with mixed line endings=20
are normalized, i.e. they have a consistent end-of-line style afterward=
=2E

I'll send a first patch shortly.

Ren=E9
