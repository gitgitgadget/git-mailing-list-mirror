From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git, Mac OS X and German special characters
Date: Sat, 01 Oct 2011 09:24:08 -0500
Message-ID: <4E872288.10503@op5.se>
References: <CAO1Q+jf=RO=sE90-mQdi+=fUWH1RLM+JTubSgSVGC5uDyhU+2A@mail.gmail.com>	<4E87182C.8050201@op5.se> <CAO1Q+jeLEp2ReNc9eOFoJxdGq6oRE3b+O=JvMNU0Kqx_eAX=7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Albert Zeyer <albzey@googlemail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 01 16:24:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA0UE-0001O1-GU
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 16:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525Ab1JAOYO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Oct 2011 10:24:14 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58949 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab1JAOYM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 10:24:12 -0400
Received: by iaqq3 with SMTP id q3so2939151iaq.19
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 07:24:12 -0700 (PDT)
Received: by 10.42.84.15 with SMTP id j15mr4534894icl.228.1317479051986;
        Sat, 01 Oct 2011 07:24:11 -0700 (PDT)
Received: from vix.int.op5.se ([12.50.161.201])
        by mx.google.com with ESMTPS id v16sm15108801ibe.0.2011.10.01.07.24.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Oct 2011 07:24:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.22) Gecko/20110906 Fedora/3.1.14-1.fc14 Thunderbird/3.1.14 ThunderGit/0.1a
In-Reply-To: <CAO1Q+jeLEp2ReNc9eOFoJxdGq6oRE3b+O=JvMNU0Kqx_eAX=7w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182552>

Please don't cull the list when replying. Reply-to-all is the
standard on git@vger.

On 10/01/2011 08:57 AM, Albert Zeyer wrote:
> On Sat, Oct 1, 2011 at 3:39 PM, Andreas Ericsson<ae@op5.se>  wrote:
>> On 10/01/2011 07:44 AM, Albert Zeyer wrote:
>>> Hi,
>>>
>>> There are problems on MacOSX with different UTF8 encodings of
>>> filenames. A unicode string has multiple ways to be represented as
>>> UTF8 and Git treats them as different filenames. This is the actual
>>> bug. It should treat them all as the same filename. In some cases (=
as
>>> on MacOSX), the underlying operating system may use a normalized UT=
=468
>>> representation in some sort, i.e. change the actual UTF8 filename
>>> representation.
>>>
>>> Similar problems also exists in SVN, for example. This was reported
>>> [here](http://subversion.tigris.org/issues/show_bug.cgi?id=3D2464).
>>> There you can find also lengthy discussions about the topic. And al=
so
>>> [here](http://svn.apache.org/repos/asf/subversion/trunk/notes/unico=
de-composition-for-filenames).
>>>
>>> This was already reported for Git earlier and there is also a patch
>>> for Git [here](http://lists-archives.org/git/719832-git-mac-os-x-an=
d-german-special-characters.html).
>>>
>>> I wonder about the state of this. This hasn't been applied yet. Why=
?
>>>
>>
>> Because the patch didn't address repositories carrying files with
>> more than one possible representation of the filename and that
>> could have lead to silent loss of data for unsuspecting users.
>>
>> The real solution to your problem is, unfortunately, to either use
>> a different and more competent filesystem, or to avoid triggering
>> the bugs in the one you're currently using.
>=20
> Well, I think it is a bug in Git itself that it treats different UTF8
> representations of the same filename as different filenames. It
> shouldn't have allowed such in the first place.
>=20
> But I see your point. I guess I will work myself on a patch here or
> extend that one.


The trouble is that they may represent two different files on a
different filesystem. The Linux kernel repo has plenty of files
that exist with both uppercase and lowercase characters, like so:
SOMEFILE_driver.c
somefile_driver.c

This is perfectly valid on all sensible and case-sensitive
filesystems, but breaks horribly on HFS. There are other, far more
"interesting" cases when you involve special chars such as the
german umlaut, or the swedish =E5=E4=F6 characters.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
