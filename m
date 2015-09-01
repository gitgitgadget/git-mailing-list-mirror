From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/3] submodule: implement `module_clone` as a builtin helper
Date: Tue, 1 Sep 2015 10:49:41 -0700
Message-ID: <CAGZ79kYDYO-q6QEmRQ4YW4ED2HAmMjZNyRaY52ix6YU1=WVNHw@mail.gmail.com>
References: <1441048767-29729-1-git-send-email-sbeller@google.com>
	<1441048767-29729-4-git-send-email-sbeller@google.com>
	<CAPig+cQVe+qmTsqqdnTXDABxNkQoeEqz07pP2pYbY_n11XMDWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 19:49:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWpgv-0007pA-60
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 19:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbbIARtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 13:49:43 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33575 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbbIARtm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 13:49:42 -0400
Received: by qkdv1 with SMTP id v1so52167684qkd.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XpOIZuKM8/KNtLmopRukG70zH/zSS+iSbPWXIG67Da4=;
        b=YcYXfiUnJphzc7rp2gqIgaSl3RP/OjbHZ8fmzS63Bwv4wAQSZuz8aFl2mQyFqZXUzp
         Sv6tdYUK2Me9FxidYn/HaDx1D/YrLlYfgOMlI/Sgx/WcvF1kUGM6dhsj1GDQW+fSO5DB
         uAQM24/eHqd7N16RV7eNlH9Rb2b7H43tCSgyS3kPKZ7R4VH8JQPzW3V0RouNOOlXzZaP
         39sWqCBs3c7ORRZBJtyFbn/fwX1Bf9QXgu0SNL0uyYQvZAjpUyuWldO66HAnihpxcSFU
         gQulf5MPCAEJOsG07SYPXr8XcjhBZCdb717Vh5QXSex7qoDZLLhpgWlO2CL4k0DnfZrB
         X0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=XpOIZuKM8/KNtLmopRukG70zH/zSS+iSbPWXIG67Da4=;
        b=FUodcF8tIrUMOT51kSDr4CaD+RTjZAMWnA0fb1buBnu0rSwrv8bfajcfazFux3qi7n
         0hUK8BScn2xZY2SwZpsnDcRw2IPzZ5H/R3S8HkMQkRDmsso4VuKqXZqXDciPpTMQrbxD
         84BF+zlpJU51c35BbTvwQILxskJReEQVBWCYKwcZeKvGssz1PA65ijRSwVkZY2w9ICj+
         +OlUTh4J/Z/HwalpFaYpOj2mEitaWOhE2q8yKAVyQ8M/U55j9t8tEQJkaDB0kCKmqkSb
         IoEYNJA5WAcm5X8wQ3ARUQiTn+LuDkcF8kXxdrRirS5eMdgLruT7v/br1OYN3tOt3P4Q
         2uHQ==
X-Gm-Message-State: ALoCoQm1ZmudbuKqCIqJ4jtRFj8fJzE6Bqp4rXAWpbB42bttUceXxMkxlnHFd+424T3PTRqJZ0pp
X-Received: by 10.129.101.7 with SMTP id z7mr28669902ywb.81.1441129781349;
 Tue, 01 Sep 2015 10:49:41 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Tue, 1 Sep 2015 10:49:41 -0700 (PDT)
In-Reply-To: <CAPig+cQVe+qmTsqqdnTXDABxNkQoeEqz07pP2pYbY_n11XMDWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277002>

took all suggestions except the one below.

>
>     if (strbuf_getcwd(&sb))
>         die_errno(...);
>     strbuf_addf(&sb, "/%s, sm_gitdir);
>     free(sm_gitdir);
>     sm_gitdir = strbuf_detach(&sb, NULL);
>
>> +       }
>> +
>> +       if (strbuf_getcwd(&sb))
>> +               die_errno("unable to get current working directory");
>
> The conditional block just above here also gets 'cwd'. If you move
> this code above the !is_absolute_path(sm_gitdir) conditional block,
> then you can avoid the duplication.

I don't get it. We need to have strbuf_getcwd twice no matter how we
arrange the code
as we strbuf_detach will empty the strbuf.

Do you mean to call strbuf_getcwd just once and then xstrdup the value,
then reset the strbuf to just contain the cwd and append the other string ?

>
>> +       strbuf_addf(&sb, "/%s", path);
>> +
>> +       p = git_pathdup_submodule(path, "config");
>> +       if (!p)
>> +               die("Could not get submodule directory for '%s'", path);
>> +       git_config_set_in_file(p, "core.worktree",
>> +                              relative_path(sb.buf, sm_gitdir, &rel_path));
>> +       strbuf_release(&sb);
>> +       free((char *)sm_gitdir);
>> +       return 0;
>> +}
