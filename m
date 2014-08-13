From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 0/1] receive-pack: optionally deny case clone refs
Date: Wed, 13 Aug 2014 09:20:41 -0700
Message-ID: <CAL=YDW=5ynUFFLVNAG=M9x-DRyEyM2q=GPVxzxHVPYDNGHYm=A@mail.gmail.com>
References: <1402525838-31975-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 18:20:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHbI6-00084W-Jk
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 18:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbaHMQUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 12:20:43 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:61182 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbaHMQUm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 12:20:42 -0400
Received: by mail-vc0-f180.google.com with SMTP id ij19so15315912vcb.11
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 09:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=imCikO72dKcPAY7ybQvtT1aKUNEXlYnuVuOCS9JzdOM=;
        b=D8NtXUFJ8WSNVvZvtjrM1aauP03+dxItUU1WhiFKgEZGVOyfQIRTJY86Zwc0agrCsP
         7BMbnCdi1hQHSz/i/64OOeT8Jg3AZC6F7jg8RCQhz7HtCKBXeMVNsuGe8MlSpRXVLgu5
         VbtXbAoN8bSryHw1I9bKn8At0AzTjg5SqU3NJC+ygU2+ke9ZYyGD8RnqEHyhkRO8ZGmC
         n2PMf0gMQ4KFpWjyLLyTNes4j5aC0JwwoIqID2OjgDgaRvkDgDdfjJ06WY8BfJQm/Dmg
         rmiUKHXxHzt90TkGJa9zqlPirwxqZ+fReSt3jWs4qNdZ8jFjKz5hCxUqm1+zmdPSGEC+
         xDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=imCikO72dKcPAY7ybQvtT1aKUNEXlYnuVuOCS9JzdOM=;
        b=AEd7KzwUzbWNW//8f7M/rkAcHePMkZDqg23tXh3SsgGSIQlzlKKLzTJq/aHAg5d0l3
         Kc8dkWalVziWS1r/6ny7SMte93CHiwszoLfZ5teK4UHk/pyFkaA3mFwyTC2/jlRPXCD2
         s8dMMFSyzQra1FyuTJOY86iOHZjWRlIbRWZsj/Y1/IrxJu9WjgbzVnS9Lqgwun0XFKiv
         1OezjSJDsEp5fCESepf38gd9ijEWLu+UXnwd6dixlaCCzmuLAL9E4wXW6riAu0eTrJzJ
         ebEkMUsJtUauYhQDtu9AvW3Kj4aIPyMHeH52EHfsmg+dzdSnJSi0dU4MJL93m38IqBj5
         X66w==
X-Gm-Message-State: ALoCoQmKFP53ulFdlI5mQl5AEl9b4F/s/D7RA25QKSWXBnHDgNS3hoCLgoZtwV+p6uTliyMIcMZL
X-Received: by 10.53.12.225 with SMTP id et1mr3932268vdd.5.1407946841234; Wed,
 13 Aug 2014 09:20:41 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Wed, 13 Aug 2014 09:20:41 -0700 (PDT)
In-Reply-To: <1402525838-31975-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255215>

David,

One possible solution can be to use the external database daemon I am
working of for ref transactions.
Since this makes all refs be stored in a dedicated database instead of
the filesystem you no longer are dependent on file system semantics.

While not in the official git trees yet I would appreciate any testing
and comments you may have it you want to test it.
https://github.com/rsahlberg/git/tree/backend-struct-db-2

Not for production use but seeing if it does build and works on your
platforms would be great.


    refsd-tdb: example refs database daemon

    refsd-tdb.c is a simple reference implementation of a refs daemon.
    This will eventually be hosted in a separate project but can live in this
    branch for now.

    Compile with :
    gcc refsd-tdb.c -o refsd-tdb -l tdb

    Run with:
    ./refsd-tdb /tmp/refsd.socket /tmp /tmp/refsd.log

    Once the refs daemon is running you can start using it with newly
    created git repositories by specifying the --db-socket and --db-repo-name
    arguments to git clone/init-db :

    git clone --db-repo-name=ROCKy --db-socket=/tmp/refsd.socket <some repo> .

    This refs daemon is an example. It should be relatively straightforward
    to modify it to attach to any other kind of data store.

regards
ronnie sahlberg


On Wed, Jun 11, 2014 at 3:30 PM, David Turner <dturner@twopensource.com> wrote:
> This issue bit us again recently.
>
> In talking with some colleagues, I realized that the previous version
> of this patch, in addition to being potentially slow, was incomplete.
> Specifically, it didn't handle the case of refs/heads/case/one vs
> refs/heads/CASE/two; these are case clones even though they strcasecmp
> different.
>
> This new version contains code to prevent this, as well as tests for
> this case.
>
> Also it uses a hashmap to make lookups constant-time.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
