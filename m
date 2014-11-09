From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 22/22] untracked cache: guard and disable on system changes
Date: Sun, 9 Nov 2014 15:34:17 +0700
Message-ID: <CACsJy8Am8+XcKzd5vqODLkCVAerMW_619c2XQsL35R6-k0F7-g@mail.gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-1-git-send-email-pclouds@gmail.com> <1415439595-469-23-git-send-email-pclouds@gmail.com>
 <CAPig+cRNpgBNr0cT6P-tsMc3McyC4aC7czcQYz0P+9_uSpkZSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 09:35:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnNxt-0007H3-Pf
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 09:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbaKIIev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 03:34:51 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:47235 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbaKIIes (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 03:34:48 -0500
Received: by mail-ig0-f172.google.com with SMTP id a13so15020262igq.5
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 00:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mjV2zPno1vqwU1SxdeDLZ5qATmYBypB3vZ1Mka7oxAo=;
        b=h4dyoDSsUMqnnCxksvrk+boEo4YAVbYBtYtuFFrheACqhPgRm/Vab8YTWiDeLo3esn
         frlQaqcToodWjNT4Sj9/vE4t7pmZ5+c3NJgYavD0slpKz99yIrmGCSzJcKyBS+Jq0/Qj
         B81ADgqUbHOD8guv4oXuB/YyvCVR4WdPt+5z3/AQUJKZ+i0Fwdf644IvVGf9ZlaTJATl
         Z3ZC5rpJsrWr4Jw7K/Whxakqvzu6WPU8gp06XgHT5koWnT2rabxnbLUY4aXfsJk9yl0g
         pTNFQW0vGVttapHJ1b6UCe1YbwDJsnKKO0kiManZ9lfL1lXtS5vlY+x++d9Zk094e5vz
         Kd/A==
X-Received: by 10.42.159.131 with SMTP id l3mr777826icx.65.1415522087893; Sun,
 09 Nov 2014 00:34:47 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Sun, 9 Nov 2014 00:34:17 -0800 (PST)
In-Reply-To: <CAPig+cRNpgBNr0cT6P-tsMc3McyC4aC7czcQYz0P+9_uSpkZSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 9, 2014 at 10:39 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> --- a/test-dump-untracked-cache.c
>> +++ b/test-dump-untracked-cache.c
>> @@ -44,6 +44,7 @@ int main(int ac, char **av)
>>  {
>>         struct untracked_cache *uc;
>>         struct strbuf base = STRBUF_INIT;
>> +       setup_git_directory();
>
> What is this change about? Is it related to the rest of this patch?

Yes. This patch makes use of get_git_work_tree() from read_cache()
below. Without setup_git_... worktree is not set up,
read_untracked_extension() thinks the repo is moved and returns no
cache. I'll make a note about this.

>
>>         if (read_cache() < 0)
>>                 die("unable to read index file");
>>         uc = the_index.untracked;




-- 
Duy
