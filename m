From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 25/27] refs: add LMDB refs storage backend
Date: Thu, 25 Feb 2016 17:12:32 +0700
Message-ID: <CACsJy8DDVbz9LnX5HM_2HB+uDvqzS7LU=12gxhxJFqYPHp0Tvg@mail.gmail.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
 <1455772670-21142-26-git-send-email-dturner@twopensource.com>
 <CACsJy8BQZCBpfmvXk+o5PqM7=zad7cxgA9B2995Rb0D0YBxEVw@mail.gmail.com> <1456346242.18017.16.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 11:13:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYsv3-00039n-4O
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 11:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759821AbcBYKNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 05:13:08 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33036 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759604AbcBYKNF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 05:13:05 -0500
Received: by mail-lf0-f52.google.com with SMTP id m1so30021940lfg.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 02:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bQdgRWZFJg26qEHgnNU/R5w8UQ24kAXBmB2+3pcr0kU=;
        b=PrC9q0PoRXyQqvWmr8MS1ANJjbnG0cCWirn9b4LBhfQij0ODRYMUnJXvr0zhsfqvHA
         K+o5+i//86vPzISO6is7MnjOmr14OO7gIv1MOsRYDUStWXsVSQlePzHn/EMu3dE6PfRR
         nLpR6/+daO6sKmRYLxRp1rnqVvcug1dTJvmTmoz/Dqsx9jAQSjQlll3FE6Metc6yUo4G
         1jH3U1or4kBZLHB9mGG9KyOPmBqShUo646UnEqRRbiFyB6yeENAPzbxGeIE6ASfLJqAu
         0uJOnpjVP077H6t03kEJlvqdR/nflurYTgMBTgI1UDK/0uG1ptTzo1kQPR8CoI0pJwvv
         be+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=bQdgRWZFJg26qEHgnNU/R5w8UQ24kAXBmB2+3pcr0kU=;
        b=BTbyfIg3PRNEFBYWdZi5QFLRolIFMzOOMVRyhLR7btr07q2jEwnz3EB/y0i3ypxrd2
         pkWDcgAPGizNiNL5tBFwwE3YVzuQn6q1W5d7MTWjOLvUHALZeHAFKpV2rA8iXLOmbf6R
         gevi4Va6T7u2O5lAc+DFeUGz3Xg/MoWqDQ6UTOFnsW9ArtABUgHhUQmim1RYF9wtzm0k
         iz2ye+CsH7yt5Na6DQxiSJYdDhvDR8i0R581TVyGnYDEpc074iNEDsMKiVpn0dZZ5Pwq
         1eoBlko68Nq0UbMSqR9fL0xTvVDUErGngrhlabfOwkAsGFwGSpHSvOuLBn8J0yLbVbxt
         T+gw==
X-Gm-Message-State: AG10YOQyZrL94eFFwrIOaTW/bbci+PxGPxmoiTHbF8blXc17ZICwAjG450ui4DBf5OB2F8i+CY7ALljCUfWN8g==
X-Received: by 10.25.157.213 with SMTP id g204mr17446785lfe.112.1456395182791;
 Thu, 25 Feb 2016 02:13:02 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 25 Feb 2016 02:12:32 -0800 (PST)
In-Reply-To: <1456346242.18017.16.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287360>

On Thu, Feb 25, 2016 at 3:37 AM, David Turner <dturner@twopensource.com> wrote:
> On Sat, 2016-02-20 at 15:59 +0700, Duy Nguyen wrote:
>> On Thu, Feb 18, 2016 at 12:17 PM, David Turner <
>> dturner@twopensource.com> wrote:
>> > LMDB has a few features that make it suitable for usage in git:
>> > ...
>>
>> I'm reading lmdb documents and hitting  the caveat section [1].
>> Random thoughts
>>
>> * "There is normally no pure read-only mode, since readers need write
>> access to locks and lock file.".
>>
>> This will be a problem for server side that serves git:// protocol
>> only. Some of those servers disable write access to the entire
>> repository and git still works fine (but won't when lmdb is used).
>> Should we do something in this case? Just tell server admins to relax
>> file access, or use MDB_NOLOCK (and when? based on config var?)
>
> MDB_NOLOCK is a good idea. I'm going to add this to the "Weaknesses"
> section of the docs and plan to fix it later, unless you feel strongly
> otherwise.

No I'm fine as long as it's documented. I was a bit disappointed when
I found out about this because after reading lmdb paper I almost
suggested we add lmdb to git.git as a submodule and prepare it to be
the next default ref backend. The quest for the "next generation"
default ref backend continues.

>> * "Avoid long-lived transactions...."
>>
>> OK we don't have a problem with this. But it makes me realize lmdb
>> transactions do not map with ref transactions. We don't open lmdb
>> transaction at ref_transaction_begin(), for example. Is it simply
>> more
>> convenient to do transactions the current way, or is it impossible or
>> incorrect to attach lmdb transactions to ref_transaction_*()?
>
> That was what I did originally, but reviewers here noted that it had
> some problems:
> 1. What if, while a transaction is open, git opens a subprocess that
> wants to make its own transaction?  There can only be one writer
> transaction open at a time.
> 2. As you note, long-lived transactions.
>
> Also, the files backend also doesn't do any locking until the last
> moment, and it's reasonable to try to be compatible with that.

Some of these should be kept in the commit message for future reference.
-- 
Duy
