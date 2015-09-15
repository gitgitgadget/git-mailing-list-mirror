From: Sukhwinder Singh <php_programmer_india@hotmail.com>
Subject: RE: Git Deployment using existing multiple environments
Date: Tue, 15 Sep 2015 12:20:36 +0530
Message-ID: <BAY180-W38D1FC3FD9892A6D147968C25C0@phx.gbl>
References: <BAY180-W16B5F49FFD3614D666B232C25F0@phx.gbl>
 <8797177dd247d4ef903603cbe6c57d7d@dscho.org>,<BAY180-W55A5095CC7E1322EA80876C25D0@phx.gbl>,<CA+P7+xq0ZPOAOONA9x9x_CYt1yf5J4Qcr5oQdQsbtu3iH3ehmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 08:50:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbk4g-0000tB-9u
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 08:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbbIOGui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 02:50:38 -0400
Received: from bay004-omc1s9.hotmail.com ([65.54.190.20]:60625 "EHLO
	BAY004-OMC1S9.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbbIOGuh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2015 02:50:37 -0400
Received: from BAY180-W38 ([65.54.190.59]) by BAY004-OMC1S9.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Mon, 14 Sep 2015 23:50:37 -0700
X-TMN: [HYDVN88Ldeou+a9vaG7Rjbe2qZNIkDs1]
X-Originating-Email: [php_programmer_india@hotmail.com]
Importance: Normal
In-Reply-To: <CA+P7+xq0ZPOAOONA9x9x_CYt1yf5J4Qcr5oQdQsbtu3iH3ehmw@mail.gmail.com>
X-OriginalArrivalTime: 15 Sep 2015 06:50:37.0184 (UTC) FILETIME=[D3CB3000:01D0EF82]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277889>

Thank you very much for the detailed reply. There is going to be just one person who'll manage all the moving of the code. On approval he'll move code from one environment to other on our own servers (right now it is being done by manual merging). Development team is not that big right now. They'll be committing all new code to the git repository we have setup up at github using all over test environment code. And the person handling the code at our server will move code from one environment to other by USING Git and not by manual merge.

Now lets say we set up a repository at github which has the latest code (all test code)., Now at each of our own servers we already have existing code, that is Test, UAT and Live. For example, first he'll pull code from github to our Test Server and then move branches to UAT and then to Live. Can it work? If it can work then can I please get some some example commands or the procedure to set it up? Time is a bit of problem right now or I would have read book suggested by Johannes. I have searched on the internet but couldn't find any similar case.

Regards,
Sukhwinder Singh

----------------------------------------
> From: jacob.keller@gmail.com
> Date: Mon, 14 Sep 2015 01:32:39 -0700
> Subject: Re: Git Deployment using existing multiple environments
> To: php_programmer_india@hotmail.com
> CC: johannes.schindelin@gmx.de; git@vger.kernel.org
>
> On Sun, Sep 13, 2015 at 10:55 PM, Sukhwinder Singh
> <php_programmer_india@hotmail.com> wrote:
>> Thank you for the reply. Let's say I do setup three different repositories then how can we move work from one repository to the other. For example, from Test Environment to UAT. If there are any links that you can provide me that I can check, it'll be great.
>>
>> Regards,
>> Sukhwinder Singh
>>
>
> Generally speaking there are two ways of moving work from one
> repository to another. The first is the "pull" where you request data
> from a remote repository and then merge that data into your own. This
> is what you're doing when you perform a clone, a fetch, or a pull.
> It's what everyone does all the time when working with a local copy of
> a "trusted" remote repository. It can also be done between two
> "trusted" remotes, if your workflow is more distributed. (ie: more
> than one "official" source).
>
> The second form of moving work is the "push" where you upload your
> work into another repository. This is most commonly used when the
> workflow is "centralized". By that I mean there is a single
> authoritative repository. Or when you are moving your own work on a
> local machine into a remotely accessible machine for others to pull
> from.
>
> As Johannes said above, you really need to determine the work flow and
> team style you want before you can really understand the best way to
> setup repositories. For example, if you setup using a distributed
> chain of command, you can have one person be the "maintainer" of each
> given trusted repository. Then, maintainers can pull (or
> equivalent-ly, pull-request) between each other. This is generally how
> a project would work when using github. One person is the maintainer,
> then a developer "forks" the project, makes some changes, then
> requests that the maintainer pull these changes. The maintainer has
> final say and will perform the final merge in cases of conflict. In
> addition, maintainer is the one who says "this is ok to go into this
> repository".
>
> You can also instead opt to use a single centralized repository. Thus,
> developers would work on code and get it ready to submit, and then
> simply perform a push. If the push requires a merge git will tell the
> user to update. There are many tools such as server side hooks in
> order to enforce various behaviors.
>
> This flow generally doesn't use sole maintainers, as each developer
> has access to push directly. It may work well for smaller teams or for
> dedicated teams who don't change developers often.
>
> A lot comes down to how your team is structured. Do you have one
> person who's job can be to maintain the repository? Do you have
> several developers who don't want to be the sole owner? Is your team
> willing to function much more distributed?
>
> In the end, it's generally always a good idea to designate at least
> one repository as the "authority" so that everyone knows where to look
> for release tags and other such data.
>
> Myself, I would say that I prefer to use the pull-request model so
> that code gets more review, as "push" based models tend not to do
> review. (Exception: Gerrit, but this uses "git push" on the command
> line to do something very much not like a push)
>
> Regards,
> Jake
 		 	   		  