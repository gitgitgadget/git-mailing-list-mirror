From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 13:54:30 -0500
Message-ID: <CAMP44s0i_wcreL024F92HfeKEngEUcW3AKM+qD+TjtVPsZj4aQ@mail.gmail.com>
References: <CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
	<CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
	<CACsJy8AtH6PQ06_-UgumV0dRdq28qKn-Oj7EAy3g+eOTGhOyYw@mail.gmail.com>
	<CAMP44s2uV6CwdyadnJXSd+3mhOdApDxqdtjNyOPj3CbdsEyG0Q@mail.gmail.com>
	<20130609043444.GA561@sigill.intra.peff.net>
	<CALkWK0kkGO8zoLSpZkaYgVr5eBX6AovYFxQZkgJKugSw0CmdXQ@mail.gmail.com>
	<20130609175554.GA810@sigill.intra.peff.net>
	<CALkWK0n0kkNZo_Xt1oT5GL-TxZP0faDExxyH3vU-+hy4uEUEtQ@mail.gmail.com>
	<20130609182246.GE810@sigill.intra.peff.net>
	<CALkWK0nsJ5ds5v7auoqN7_vXhOoasJ3y99njZt5btPVqRCF2zA@mail.gmail.com>
	<20130609184943.GH810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:54:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlklM-0002tV-Vo
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768Ab3FISyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:54:33 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:53612 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab3FISyc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:54:32 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so5134591lab.27
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=s406pYB04EamDbf0dGlHoZuabt/9tfiG+bkl0XecCVs=;
        b=ZOjS/PS5836ZNOf4Zg9DL1W//lzIVJVPm18YZ1zS4HegPfWexoXuC2tnTbFnX7kmUI
         ik2W8HFis7gF1CEo94TmhXptZYqKHMdlC/eaVepfZUPaN3D0km8CZYsAGbQzU/iejhVL
         uNNHk3Gh9eVv8Tn4hZIH0kzLOHL6okskdhfoMK7zLDh+y3Ctr127y4z4Tdz64TyBTv8Y
         RDAgVduYUTYqYBEgEnj5WbEdZQmH9eIaD34RilsQ9BdQZEEbDJ+pkRhO4wKI9Afawqis
         EZVz+0qVBG3IV4J6Lyzr6LlRwoKDvb7iQOyUfwOdgQepCOUSIwbstMqg5oj12Fi38Kfq
         1L2Q==
X-Received: by 10.152.27.170 with SMTP id u10mr3412504lag.45.1370804070924;
 Sun, 09 Jun 2013 11:54:30 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 11:54:30 -0700 (PDT)
In-Reply-To: <20130609184943.GH810@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227097>

On Sun, Jun 9, 2013 at 1:49 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 10, 2013 at 12:14:36AM +0530, Ramkumar Ramachandra wrote:
>
>> Jeff King wrote:
>> > Sorry, I don't have patches. It is a hard problem for which I do not
>> > have the solution, which is kind of my point.
>>
>> So, what is the problem?  We are moving towards what we think is the
>> way forward.  Nobody said that it is the theoretical best, but it's
>> _much_ better than doing nothing, no?
>
> I thought I already said: there is a lot of global state that is assumed
> to be wiped between various functions and git commands. For example, you
> cannot just call cmd_log twice in the same process and get the right
> answers. I haven't seen a proposal for dealing with that.
>
>> Then whom are we to ask about this feasibility?  All the core
>> contributors (including Junio) are in the CC.  Nobody has said
>> anything.  So, are you proposing that we sit and ponder over our
>> theoretically-indeterminate-feasibility problem?  There is no magic
>> bullet, Jeff.  We write code, and we fix bugs as and when they crop
>> up; there's really not much else anyone can do.  Help by writing code,
>> or reviewing someone else's code.
>
> I mentioned a bug above. How are you going to fix it? Where is your
> patch to review?

--- a/git.c
+++ b/git.c
@@ -359,7 +359,7 @@ static void handle_internal_command(int argc,
const char **argv)
                { "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
                { "init", cmd_init_db },
                { "init-db", cmd_init_db },
-               { "log", cmd_log, RUN_SETUP },
+               { "log", cmd_log, RUN_SETUP | NEEDS_FORK },
                { "ls-files", cmd_ls_files, RUN_SETUP },
                { "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
                { "ls-tree", cmd_ls_tree, RUN_SETUP },

Done.

But either way, that's orthogonal to the builtin/lib.a issue. It has
absolutely nothing to do with Ruby, or my experiment. It's about the
sequencer and notes, and all that stuff for which I just sent
forty-something patches. If you have a better idea how to fix that,
let's see it.

-- 
Felipe Contreras
