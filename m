From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH/RFC] Make help behaviour more consistent
Date: Mon, 11 Mar 2013 20:51:26 +0200
Message-ID: <513E27AE.6050000@bracey.fi>
References: <1362937729-9050-1-git-send-email-kevin@bracey.fi> <7v1ubmd4dt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 12 01:48:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFDOc-0003n8-KY
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 01:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033Ab3CLAsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 20:48:17 -0400
Received: from 4.mo1.mail-out.ovh.net ([46.105.76.26]:58666 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754947Ab3CLAsO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 20:48:14 -0400
X-Greylist: delayed 16799 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Mar 2013 20:48:14 EDT
Received: from mail420.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 3A6B2FF9416
	for <git@vger.kernel.org>; Mon, 11 Mar 2013 20:08:09 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 11 Mar 2013 20:51:29 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 11 Mar 2013 20:51:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.1 (mo1.mail-out.ovh.net)
In-Reply-To: <7v1ubmd4dt.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 2859504290377666782
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrfeejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrfeejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217928>

On 11/03/2013 05:03, Junio C Hamano wrote:
> Hmm, I feel more confused than convinced after reading the above
> three times.  Perhaps that is because I am too used to the way how
> "git" potty itself behaves, especially the part that "git help git"
> is the way to ask "git" (the first token on the command line) to
> give me "help" about "git" (the second) itself.

But you are nowhere told that "git help" will give you information on 
any topic other than Git commands. Starting from just typing "git", all 
you are told is that you can type "git help <command>". Given that 
information, you could at least logically deduce that "git help help" 
will give you help on "git help". (Not that it would help anyway - even 
git-help.txt doesn't say that you can specify anything other than a Git 
command, like "git" or "cli". But sounds like Philip's already on there 
case there).

If you can figure out "man git" for yourself (and if it's available - 
Windows?) then from there you're explicitly told how to directly access 
all the other docs using man itself, including gitrevisions(7), etc.

And having gotten to "man gitrevisions", I figured out that "git help 
revisions" could get to the HTML equivalent. Not documented, but at 
least fits the pattern, give or take a hyphen.  But I never figured out 
"git help git", until I read the source. Why do I need to add the extra 
"git" to the help command for that page, and that page only? "git" isn't 
a Git command, and there's no "man gitgit" topic! Even if I explicitly 
try to point explicitly that I want a web page with "git help -w", I 
don't get it...

I think at the very minimum you need to make it explicitly clear right 
up front that "git help git" is available:

    See 'git help git' for more information on Git
See 'git help <command>' for more information on a specific command.

Seems ugly though. I'm at a loss to understand why "git help", the 
manual launching command, shouldn't by default simply launch the root of 
the manual tree, rather than replicate the behaviour of "git"/"git --help".

And something needs to be done to advertise the general existence of 
usage on commands. "-h" is currently hidden on page 4 of "man gitcli". 
(Is it anywhere else?)  I've managed to avoid finding out about it for 
years! Checking a few people around me, none of them knew about it either.

At the minute "git" tells you about "git --help", which shows usage, but 
"git add --help" launches the manual. (Huh?) Given that, I always 
assumed there was no usage available for individual commands - if there 
was usage, surely it would be there on --help, like on "git". Never 
occurred to me it would be there under "-h" instead.

So how about going further than that patch, and making it even simpler. 
Collapse --help and -h to be synonyms. Then under either spelling, 
--help|-h always shows usage for "git" or "git <command>", as per GNU 
guidelines.

Then the manual launch only happens for "git help ..." and, "git help" 
on its own launches the root. And the output of "git [--help]" ends with:

    See 'git help [<command>]' for more information.

Kevin
