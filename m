From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] rebase: new convenient option to edit a single commit
Date: Tue, 4 Mar 2014 17:24:49 +0700
Message-ID: <CACsJy8CSaAnVrFnhxRd=jPmXCat5AObNRLKzCesbdx3JS83PnA@mail.gmail.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
 <1393728794-29566-1-git-send-email-pclouds@gmail.com> <1393728794-29566-4-git-send-email-pclouds@gmail.com>
 <CAPig+cTn-YcWHsGRKUZWqACJ5ZspWoB+f4i7hNj09_4Ci6odiw@mail.gmail.com>
 <CACsJy8Ct41PRb=_Ez7FLXbdiZkTU-tFYqtAxow9mCw7wYAfOhg@mail.gmail.com> <53159601.8020702@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 04 11:25:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKmXP-000448-D8
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 11:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768AbaCDKZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 05:25:22 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:62131 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756661AbaCDKZU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 05:25:20 -0500
Received: by mail-qc0-f174.google.com with SMTP id x13so4969524qcv.5
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 02:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RkKyGHXk3buGTTjcnsS/yBY+s/yd5p6/+Fv3rOeE2H0=;
        b=KVIPbo7itYoYWlucXtNYkIFx5HwxQDatkDJqzLgSdbpkYrgcJqoFSbi2Wk1X2bHmnO
         ybMtYC5YAnp2i03qy9HIrcGbyArKuQlu/oaIpvt77hxTCauR3hLO1NEZTXEI8U8FWjnB
         3GrvpOtnxh2tBQdf1G6YdNnbIDk23u+ZkEmO2FWiFr641p9NOM4rnj86eBDa1dHeDhyW
         1OcLXJpW+vOLkV+izHr8lHWL77L0N6JE/Pdni6Yy8PUQmsV4I8+Rdj+QmkjhGBpRGr1W
         TA4P6RftLhx50vdR/vDT9YdE24OAQgdh45KJtGpg6DFYK2puNBL1NvWT38FC+PzaDKDH
         SfjQ==
X-Received: by 10.224.26.71 with SMTP id d7mr8791810qac.89.1393928719689; Tue,
 04 Mar 2014 02:25:19 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Tue, 4 Mar 2014 02:24:49 -0800 (PST)
In-Reply-To: <53159601.8020702@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243336>

On Tue, Mar 4, 2014 at 3:59 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On Tue, Mar 4, 2014 at 3:28 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> Is it correct to single out only "edit" for special treatment? If
>>> allowing "edit" on the command-line, then shouldn't command-line
>>> "reword" also be supported? I, for one, often need to reword a commit
>>> message (or two or three); far more frequently than I need to edit a
>>> commit.
>>>
>>> (This is a genuine question about perceived favoritism of "edit", as
>>> opposed to a request to further bloat the interface.)
>>
>> Heh I had the same thought yesterday. The same thing could be asked
>> for "git commit --fixup" to send us back to the fixed up commit so we
>> can do something about it. If we go along that line, then "git commit"
>> may be a better interface to reword older commits..
>
> I disagree.  "git commit --fixup" doesn't rewrite history.  It just adds
> a new commit with a special commit message that will make it easier to
> rewrite history later.  I think it would be prudent to keep the
> history-rewriting functionality segregated in "git rebase", which users
> already know they have to use with care [1].

Just to be clear I didn't mean to modify --fixup behavior. It could be
--amend-old-commit or something like that. It's actually --amend that
made me want to put the UI in "git commit". But it's a bad idea
(besides what you pointed out) because after you're done, you still
need to do "git rebase --continue".

> But the next question is whether "git rebase" should have shortcuts for
> *most* of its line commands.  All of the following seem to make sense:
>
>     git rebase --edit COMMIT
>
>         A long-form for the -e option we have been talking about.
>         It is unfortunately that this spelling sounds like the
>         "--edit" option on "git commit --edit" and "git merge --edit",
>         so people might use it when they really mean
>         "git rebase --reword COMMIT".
>
>     git rebase --reword COMMIT

Sounds good.

>     git rebase --fixup COMMIT
>     git rebase --squash COMMIT

This is not interactive (except when merge conflicts occur), is it?

A bit off topic. I sometimes want to fix up a commit and make it stop
there for me to test it again but there is no such command, is there?
Maybe we could add support for "fixup/edit" (or "fe" for short) and
"squash/edit" ("se"). Not really familiar with the code base to do
that myself quickly though.

>     git rebase --kill COMMIT
>
>         Remove the commit from history, like running "git rebase
>         --interactive" then deleting that line.

Yes! Done this sometimes (not so often) but a definitely nice thing to
have. I'd go with --remove or --delete though.
-- 
Duy
