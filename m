From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: Problem with Git.pm bidi_pipe methods
Date: Tue, 28 Oct 2008 10:12:44 +0100
Message-ID: <4906D78C.4030409@jaeger.mine.nu>
References: <20081024001446.GE17717@plop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Philippe Bruhat (BooK)" <philippe.bruhat@free.fr>
X-From: git-owner@vger.kernel.org Tue Oct 28 10:14:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KukeP-000512-CB
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 10:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbYJ1JMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 05:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbYJ1JMt
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 05:12:49 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:60816 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751801AbYJ1JMs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 05:12:48 -0400
Received: (qmail 444 invoked from network); 28 Oct 2008 09:12:45 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 28 Oct 2008 09:12:45 -0000
Received: (qmail 15713 invoked from network); 28 Oct 2008 09:12:45 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 28 Oct 2008 09:12:45 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <20081024001446.GE17717@plop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99281>

Philippe Bruhat (BooK) wrote:
> Hi,
>
> To be able to call commit-tree from a Perl program, I had to use
> command_bidi_pipe() to pass the message on standard input, and get the
> new commit id on standard output. The only problem I have is that the
> method doesn't work (or at least, doesn't work like the other
> command_... methods).

Not really an answer on how to fix Git.pm, but: you may want to subclass 
Git.pm and add your own methods ad interim. See the thread "[PATCH] 
Git.pm: do not break inheritance" [1] about how to subclass (I see that 
this patch is actually in {next,pu} already, and anyway you can use the 
runtime patching approach I described there).

That approach of using subclasses has two benefits: (a) it will tend to 
make your code work with various versions of Git (i.e. one without a 
fixed command_bidi_pipe method), and (b) you will be much more free to 
extend the code. The drawback will be of course that your inventions 
won't necessarily make it back to Git.pm, but I'm tempted to think that 
some innovation taking place before settling on what should make it back 
to Git.pm (or, if incompatible, possibly a new Git.pm) would be worthwhile.

For an actual example in writing Git subclasses see "[ANNOUNCE] intergit 
repository-linking tool (early release)" [2].

Christian.

[1] http://article.gmane.org/gmane.comp.version-control.git/98568
[2] http://article.gmane.org/gmane.comp.version-control.git/99197
