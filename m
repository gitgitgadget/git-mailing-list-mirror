From: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
Subject: Re: GIT get corrupted on lustre
Date: Thu, 17 Jan 2013 08:07:31 -0500
Message-ID: <50F7F793.80507@giref.ulaval.ca>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca> <50EDDF12.3080800@giref.ulaval.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Maxime Boissonneault <maxime.boissonneault@clumeq.ca>,
	=?ISO-8859-1?Q?S=E9bastien_Boisvert?= 
	<sebastien.boisvert@calculquebec.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 17 14:07:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvpCF-0005O0-Ij
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 14:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547Ab3AQNHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 08:07:34 -0500
Received: from serveur.giref.ulaval.ca ([132.203.7.102]:34152 "EHLO
	mailhost.giref.ulaval.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755955Ab3AQNHd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 08:07:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 0D4EF10202D;
	Thu, 17 Jan 2013 08:07:32 -0500 (EST)
X-Virus-Scanned: amavisd-new at giref.ulaval.ca
Received: from mailhost.giref.ulaval.ca ([127.0.0.1])
	by localhost (mailhost.giref.ulaval.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bdJ1i8Zm1zdw; Thu, 17 Jan 2013 08:07:31 -0500 (EST)
Received: from [132.203.7.22] (melkor.giref.ulaval.ca [132.203.7.22])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 64617101936;
	Thu, 17 Jan 2013 08:07:31 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130105 Thunderbird/17.0.2
In-Reply-To: <50EDDF12.3080800@giref.ulaval.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213850>

Hi!

I still have the corruption problems....

We just compiled a git without threads to try... (by the way, 
--without-pthreads doesn't work, you have to do a --disable-pthreads 
instead).

And to remove the warnings about threads at "git gc" execution, I did a:

git config --local pack.threads 1

and cloned a repository and started to do:

git gc

once every hour.

Then this night (at 05:35:02 exactly), the same error as usual occurred:

error: index file 
.git/objects/pack/pack-bf0748cee64a1964be0a1061c82aca51c993b825.idx is 
too small
error: refs/heads/master does not point to a valid object!

So now I am convinced that it is not a thread problem....

I am kind of discouraged, we like to use git, but in this case we have 
this error which seems unsolvable!

Anyone has a new idea?

Thanks,

Eric


On 01/09/2013 04:20 PM, Eric Chamberland wrote:
> Hi Brian,
>
> On 01/08/2013 11:11 AM, Eric Chamberland wrote:
>> On 12/24/2012 10:11 AM, Brian J. Murrell wrote:
>>> Have you tried adding a "-q" to the git command line to quiet down git's
>>> "feedback" messages?
>>>
>>
>
> I moved to git 1.8.1 and added the "-q" to the command "git gc" but it
> occured to return an error, so the "-q" option is not avoiding the
> problem here... :-/
>
> command in crontab:
>
> cd /rap/jsf-051-aa/ericc/tests_git_clones/GIREF && for i in seq 10; do
> /software/apps/git/1.8.1/bin/git gc -q || true;done
>
> results:
> error: index file
> .git/objects/pack/pack-1f09879c88cd71a15dcc891713cf038d249830ad.idx is
> too small
> error: refs/remotes/origin/BIB_Branche_1_4_x does not point to a valid
> object!
>
> and this clone was a "clean" clone in which only "git qc -q" has been
> run on....
>
> I still have a doubt on threads....
>
> Eric
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
