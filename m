Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50F4F207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 02:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S978411AbdDYCvp (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 22:51:45 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35712 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940236AbdDYCvo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 22:51:44 -0400
Received: by mail-io0-f195.google.com with SMTP id d203so52410460iof.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 19:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R78OstG1MW30lCTsEEnQ8h8td1TDxCTzpJ4S/NFzU6U=;
        b=om+Q+j3/yJD39KVnGkenZ2BQEIVoUwAoLMPB9WO+8XYYRr6171RLpy+BlibWr52y3I
         k77sjE+Wk3zIOLikt/ntqATr0l4reAjoYNCvf4AOjgNKEw2d21lvD0MQATzDYHquZD8y
         gvYFSsifXiQ9WH0SfC1p1IT3O9nPVQx8psB5efNfF1k1cPgpLgnc8m4PmSKtIohcuFji
         ClyzFjcIx8yMi6IRRzGo0eD/j7Ix7OUJjIUapd1EK9UxiVOYcpGHmnscyhHamwyIsuow
         ryLQAOEkY1KTQkUhlvVrXZNSXyszc4/dGbIqMtqqQbZ1ULNoTx9YrxO/QE3Cl/WPZfLU
         ainw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R78OstG1MW30lCTsEEnQ8h8td1TDxCTzpJ4S/NFzU6U=;
        b=GKkGUbTYLg5XKLR85exPq4Pq/ogxy4Hu2/3rOlhREO65qxnIsCK9l9JuC/nscuqct0
         eHJnR28aMEv/IlOgVpsfzwASOIU8Eo6EuX9Sawy+In8RidH7Pbh9vOWeQXlW0t+MI4+0
         +CXywFlGtKOgvFSqD0WzV9A5eH8IkV336cw9jWvCr9PbOoZ0SvhYww4XXxAod6T2JgTJ
         CNiJeLoLsahNVWSLBn9xH1uW/VXMMVEW+ctMvn18S782Lga9Oky3PXDAgMAQGl8gxoN4
         /KEEn0Wl+4tv3fa/9OlA7iYm9l2M+0d95c4FIFoAhmxW9UaGhgiMkAnA5dd3Yogo2W2a
         dxTg==
X-Gm-Message-State: AN3rC/7j2GXwtKqvvNIoAkSU+1VAR31NJBpZLwAh95MkfvXxTQkqLdiE
        0SVSdSMKV5clwQ==
X-Received: by 10.107.201.194 with SMTP id z185mr10861322iof.220.1493088702913;
        Mon, 24 Apr 2017 19:51:42 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:85c7:fa47:7aaf:2307])
        by smtp.gmail.com with ESMTPSA id 93sm8926044ioj.58.2017.04.24.19.51.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 19:51:42 -0700 (PDT)
Date:   Mon, 24 Apr 2017 19:51:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        j6t@kdbg.org, sbeller@google.com, e@80x24.org, peff@peff.net
Subject: Re: [PATCH v6 12/11] run-command: don't try to execute directories
Message-ID: <20170425025140.GH28740@aiede.svl.corp.google.com>
References: <20170424223752.GB105623@google.com>
 <20170424235042.26627-1-bmwill@google.com>
 <20170425001724.GG28740@aiede.svl.corp.google.com>
 <xmqqr30hxn72.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr30hxn72.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Until we switched from using execvp to execve, the symptom was very
>> subtle: it only affected the error message when a program could not be
>> found, instead of affecting functionality more substantially.
>
> Hmph, what if you had bin/ssh/ directory and bin2/ssh executable and
> had bin:bin2 listed in this order in your $PATH?  Without this change
> you'll get an error and that's the end of it.  With this change,
> you'd be able to execute bin2/ssh executable, no?  So I am not sure
> if I agree with the "this is just an error message subtlety".

I think you misunderstood what I meant.  execvp() does not have this
bug.  In current master, run_command() (within function sane_execvp())
double-checks execvp()'s work when it sees EACCES to decide whether
to convert it into a more user-friendly ENOENT.  Because of this bug,
if you have a bin/ssh/ directory and no bin2/ssh executable, instead
of reporting this condition as a user-friendly ENOENT, it would leave
it as EACCES.

> What does execvp() do when bin/ssh/ directory, bin2/ssh
> non-executable regular file, and bin3/ssh executable file exist and
> you have bin:bin2:bin3 on your $PATH?  That is what locate_in_PATH()
> should emulate, I would think.

Good catch.

 $ mkdir -p $HOME/bin1/greet
 $ mkdir $HOME/bin2
 $ printf '%s\n' 'echo bin2' >$HOME/bin2/greet
 $ mkdir $HOME/bin3
 $ printf '%s\n' '#!/bin/sh' 'echo bin3' >$HOME/bin3/greet
 $ chmod +x $HOME/bin3/greet
 $ PATH=$HOME/bin1:$HOME/bin2:$HOME/bin3:$PATH perl -e 'exec("greet")'
 bin3

It needs to skip over non-executable files.

I think this means we'd want to reuse something like is_executable
from help.c.

[...]
>>> +		if (!stat(buf.buf, &st) && S_ISREG(st.st_mode))
>>>  			return strbuf_detach(&buf, NULL);
>>
>> Should this share code with help.c's is_executable()?
>>
>> I suppose not, since that would have trouble finding scripts without
>> the executable bit set.

I confused myself about the script special-case: they are supposed to
have the executable bit set, too --- the special-casing is just about
lacking #!/bin/sh at the top (and hence not being directly executable
with execve).

>> I was momentarily nervous about what happens if this gets run on
>> Windows. This is just looking for a file's existence, not
>> executability, so it should be fine.
>
> When we are looking for "ssh" with locate_in_PATH(), shouldn't we
> look for "ssh.exe" on Windows, though?

Fortunately this is in a #if !defined(GIT_WINDOWS_NATIVE) block.  It's
probably worth adding a comment so people know not to rely on it
matching Windows path search behavior.

Thanks for looking it over,
Jonathan
