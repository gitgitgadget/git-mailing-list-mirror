From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 1/2] worktree: add 'for_each_worktree' function
Date: Mon, 31 Aug 2015 15:47:39 -0400
Message-ID: <CAPig+cSweTu=t4vekV6ihAYSzdDHZMQdx-PRt9_+rYr9SrujPw@mail.gmail.com>
References: <1440961839-40575-1-git-send-email-rappazzo@gmail.com>
	<1440961839-40575-2-git-send-email-rappazzo@gmail.com>
	<CAPig+cTHZrQn8LpfftcsAQhFAykgDorbR97tkcuSCFYD_ngs9g@mail.gmail.com>
	<CANoM8SUoJAPBwEO=udhaR0WcUkZropEJ5G_SESnkHVtAQHxJQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 21:47:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWV3R-0003MN-Dt
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 21:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbbHaTrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 15:47:41 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34770 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbbHaTrk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 15:47:40 -0400
Received: by qkct7 with SMTP id t7so13989126qkc.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 12:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=i/eUeOzPZOuVioBi+4nH9o0J+ZRdDCiqXAFU3HbKzVE=;
        b=mYsqJtbAEl9mbvsrwgvobKjvcqhfYWhQ7y229mrhoLCm/wJG3KNAwfldFzJ/mdyrYu
         Nn3eGc33wYsD9bIH2hG2+3eAMdcV4GVBsJFYwK6x0omfMNWOqPKq3/KHdJXRSUQuFYAM
         goYCfR9um+2lO9RPjRVUAwvwmtAIuv4NBdHT0vjlWLAHf6dGvvaalVZ5cV2fG3rjDHYL
         oWout1nlOOIjw4CQjfR85LmafZlaOy2IJkMT78O5pHBScAMpzCPtPSWikX3Vb6NiPq87
         IYrN0hMDGvSh1nWddeZ3pbciGxmXTNTXCko5C/23TlqT6h27zAk7tFtohxb3G9LByiLD
         DGDQ==
X-Received: by 10.129.41.209 with SMTP id p200mr16067922ywp.131.1441050459793;
 Mon, 31 Aug 2015 12:47:39 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Mon, 31 Aug 2015 12:47:39 -0700 (PDT)
In-Reply-To: <CANoM8SUoJAPBwEO=udhaR0WcUkZropEJ5G_SESnkHVtAQHxJQQ@mail.gmail.com>
X-Google-Sender-Auth: EHZbujaMls4K-skwSYD-BjJKiOA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276925>

On Mon, Aug 31, 2015 at 2:57 PM, Mike Rappazzo <rappazzo@gmail.com> wrote:
> I wasn't sure that a bare repo would be considered a worktree.  I
> don't think that it would be
> a good idea to include it.  In the same vein that I can't checkout a
> branch in a bare repo, it
> figure that it shouldn't be in the list.

I forgot to mention in my previous response that I have the opposite
view, and think that a bare repo should be included in the output of
"git worktree list". The reason is that the intention of "git worktree
list" is to give the user a consolidated view of the locations of all
components of his "workspace". By "workspace", I mean the repository
(bare or not) and its worktrees.

In the typical case, the .git directory resides within the main
worktree (the first item output by "git worktree list"), thus is
easily found, however, if "git worktree list" hides bare repos, then
the user will have no way to easily locate the repository (without
resorting to lower-level commands or peeking at configuration files).
