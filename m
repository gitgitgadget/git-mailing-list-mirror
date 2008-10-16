From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [gambit-list] Separating generated files?
Date: Thu, 16 Oct 2008 15:29:27 +0200
Message-ID: <adf1fd3d0810160629o31540fd7ke08288961a046ee2@mail.gmail.com>
References: <E6D34628-783D-4597-8B00-C10F27F63BE2@iro.umontreal.ca>
	 <48F5D86B.6040501@pflanze.mine.nu>
	 <fcaeb9bf0810150754s613f2c44pd8341711d9d73f73@mail.gmail.com>
	 <vpqiqrt3mgs.fsf@bauges.imag.fr>
	 <48F61D77.3080100@drmicha.warpmail.net>
	 <48F62834.9080102@pflanze.mine.nu> <48F72CED.6030508@pflanze.mine.nu>
	 <adf1fd3d0810160512if056c3dt5eeec6a097e1a7a7@mail.gmail.com>
	 <48F73463.2050902@pflanze.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Marc Feeley" <feeley@iro.umontreal.ca>,
	"Gambit List" <Gambit-list@iro.umontreal.ca>
To: "Christian Jaeger" <christian@pflanze.mine.nu>
X-From: git-owner@vger.kernel.org Thu Oct 16 15:31:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqSw7-0000xP-80
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 15:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbYJPN3a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Oct 2008 09:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbYJPN3a
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 09:29:30 -0400
Received: from gv-out-0910.google.com ([216.239.58.188]:33347 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbYJPN33 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Oct 2008 09:29:29 -0400
Received: by gv-out-0910.google.com with SMTP id e6so746802gvc.37
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 06:29:27 -0700 (PDT)
Received: by 10.103.16.14 with SMTP id t14mr1417361mui.25.1224163767189;
        Thu, 16 Oct 2008 06:29:27 -0700 (PDT)
Received: by 10.102.247.10 with HTTP; Thu, 16 Oct 2008 06:29:27 -0700 (PDT)
In-Reply-To: <48F73463.2050902@pflanze.mine.nu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98379>

On Thu, Oct 16, 2008 at 2:32 PM, Christian Jaeger
<christian@pflanze.mine.nu> wrote:
> Santi B=E9jar wrote:
>>
>> It looks like the html and man branches of git.git.
>>
>> http://git.kernel.org/?p=3Dgit/git.git;a=3Dshortlog;h=3Dhtml
>> http://git.kernel.org/?p=3Dgit/git.git;a=3Dshortlog;h=3Dman
>>
>> They are automatically generated when Junio pushes the branches to
>> kernel.org. Afterwards you can do a "make quick-install-html" and
>> install the preformated html pages from these branches. They are
>> generated with the dodoc.sh script from the todo branch in git.git
>> (look inside for instructions):
>>
>> http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob_plain;f=3Ddodoc.sh;h=
b=3Dtodo
>
> This script only generates the html / man branches, it doesn't help f=
ind the
> right version for a given git version, right?

Right, one script to generate and one to get the right version.

>
> The differences are:
>
> - the html / man branches have a strictly linear history

Yes, because in this case it is not needed to replicate the whole
history, but it could be improved.

> and are centrally maintained. This solves the distribution issue for =
end users. But while
> developping the compiler, the developers may need to go back in the h=
istory
> of their own development (e.g. when the current compiler doesn't work
> anymore), and the suspected usefulness of being able to see and track
> differences in the generated code also isn't available for a strictly
> central approach.

So, you can divide the problem in two: (a) generated files in the
remote repositories (these can be generated automatically on the
server or in a dedicated server) (b) local generated files for local
commits. If both follow the same format to specify the original commit
you can use the same script to get it.

>
> - the script above is only for creating and committing the derived fi=
les, in
> a hook similar to the one I suggested in build/.git/hooks/commit-msg;=
 this
> is the "cd build; git commit -m 'generated files for source repositor=
y
> commit
>> `git rev-parse HEAD`'" part; the more interesting part comes from
>> automatically finding the right commit in the generated branches for=
 a given
>> source commit. This is what I intend to solve with the
>> "intergit-find-matching-commit-in" script. Said in a simpler way: th=
e git
>> html / man branches do not offer automatically resolvable linking.

They offer this (Autogenerated HTML docs for v1.6.0.2-530-g67faa) but
there is no script around it.

My point was that there are other project keeping generated files (and
sometimes I would like it too), so you can see what they are doing. At
the end, maybe, you system could be usefull for them also.

Santi
