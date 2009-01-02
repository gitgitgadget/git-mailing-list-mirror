From: "Devin Doucette" <devin@doucette.cc>
Subject: Re: [PATCH] gitweb: Handle actions with no project in evaluate_path_info
Date: Thu, 1 Jan 2009 19:21:55 -0700
Message-ID: <a899d7ef0901011821x166f173dx47bdb41326391696@mail.gmail.com>
References: <a899d7ef0812272326j1a407c30k936bf8d8975c9063@mail.gmail.com>
	 <200901020058.30748.jnareb@gmail.com>
	 <cb7bb73a0901011646n6a1368caq797a5f2849daec77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 03:23:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIZh4-0004SM-3y
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 03:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513AbZABCWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 21:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755462AbZABCWA
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 21:22:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:61071 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558AbZABCV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 21:21:59 -0500
Received: by nf-out-0910.google.com with SMTP id d3so757759nfc.21
        for <git@vger.kernel.org>; Thu, 01 Jan 2009 18:21:56 -0800 (PST)
Received: by 10.210.109.10 with SMTP id h10mr20412749ebc.110.1230862915555;
        Thu, 01 Jan 2009 18:21:55 -0800 (PST)
Received: by 10.210.123.20 with HTTP; Thu, 1 Jan 2009 18:21:55 -0800 (PST)
In-Reply-To: <cb7bb73a0901011646n6a1368caq797a5f2849daec77@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104356>

On Thu, Jan 1, 2009 at 5:46 PM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> Actually, the early bailout was sort of intentional. The problem is
> the ambiguity: does git.example.com/opml refer to the opml project, or
> does it refer to the opml action?

Good point. Though my patch does not break any existing functionality,
it does not fix the case where a project matches the action.

> HOWEVER, href() *does* create the opml action as git.example.com/opml,
> so gitweb is currently broken in the sense that ti doesn't correctly
> parse its own pathinfo output. So the question is: shall we go with
> this patch, preventing pathinfo from working for projects named like a
> no-project gitweb action, or should we fix href() to not generate
> pathinfo unless project is defined?

A variation of the latter approach is to modify href() to use pathinfo
if there is a project or there is no project matching the name of the
action. The only downside to this approach is that a URI that refers to
an action when first generated could resolve to a project in the future,
if a project of the same name were added.

--
Devin Doucette
