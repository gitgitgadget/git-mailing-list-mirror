From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Run hooks with a cleaner environment
Date: Wed, 07 Dec 2005 10:57:30 -0800
Message-ID: <7voe3srazp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0512061716030.25300@iabervon.org>
	<7voe3tzqn8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512071236260.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 19:59:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek4UI-00040n-Gb
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 19:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbVLGS5d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 13:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbVLGS5d
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 13:57:33 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:21935 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751462AbVLGS5c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 13:57:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051207185657.ZKIB3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Dec 2005 13:56:57 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0512071236260.25300@iabervon.org> (Daniel
	Barkalow's message of "Wed, 7 Dec 2005 12:47:39 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13338>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Tue, 6 Dec 2005, Junio C Hamano wrote:
>
>> Daniel Barkalow <barkalow@iabervon.org> writes:
>> 
>> > GIT_DIR is set to the repository that got the push,
>> 
>> That is done by receive-pack; it chdir()s into the repository
>> and does its thing, and the hooks are called from there; I'd
>> expect cwd to be the repository ('.git'), GIT_DIR to be dot
>> ('.').
>
> I thought I was seeing the full path of the repository as GIT_DIR and I 
> didn't check the cwd.

I do not do this myself, but I was wondering what would happen
if somebody has "export GIT_DIR=/var/filfre" in ~/.profile.

Well, I know what would happen, actually --- things would not
work when you do fetch/push because the tools want to use the
path given from the other end but the environment overrides it
with GIT_DIR.
