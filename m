Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E68E820D0A
	for <e@80x24.org>; Tue, 30 May 2017 00:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750971AbdE3Aw7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 20:52:59 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33500 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdE3Aw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 20:52:58 -0400
Received: by mail-pf0-f176.google.com with SMTP id e193so56550806pfh.0
        for <git@vger.kernel.org>; Mon, 29 May 2017 17:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ca42ygmvH05jJ7A+aJj9y9OER9Lqsq5TlINIKP68KTI=;
        b=H+9CSvdbjbBTdzIxCNzUlYjoRG8flfaqGv9lTgQZE+MlpA7xUMiZaixVw7thfpSHff
         falRsnODpWOV/wBhWNS7RfeV7sv79ba2gB6TmEpgKpWZ8+9i6TeuHPkseB4BBUe5TIoU
         d8/1U6w42VJM1Ydct1xlRLX2CgukU7Z0Kkg5gRxHGH0odwcPHjRt1zidd2bgMkyMgG1d
         cflyg3A3PJww0S4nuEEoJzjT3oQI3p74VDtejYAz9SC3KmtNddHgWSXO1DNa5NwpDcxh
         tq63xxqUtsLkMLveGh4+H3ZwexkNCfGeNP+cwNN569KueuokPVxUq/ew/wHy0qavfq19
         t2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ca42ygmvH05jJ7A+aJj9y9OER9Lqsq5TlINIKP68KTI=;
        b=po81WO7shM0sVdkX2d55Usw8eqtlzZy+YzEwDJIlfLCHBgVMb3xa8SLHXIwrbCOd4F
         L/A6ul7QgmEbTwr/aVZvYNKjvNPgwqMTHfooauCYcsT6sfVbZjWYaVuUzIVFU6yVNKJw
         fP7K16QtlFYBQ/IhC+XnI0naUwJl1r/RfPoEiXshbDUgq1rTxAm2j7zxvsglcM7vqF5J
         y64B6d59l0PQf3jY+d15v1bvjdCEswYRy2PP0vOk8JTDcstj1FKsi1dvWRYJOo7kUK2S
         Bn+EFtRlK9yaDFz+It+VdPm5B+13bKF+9ob7ERp8KkDFNWhCgHFPl+MBEO/31qpMQHJW
         E8TA==
X-Gm-Message-State: AODbwcBtziEpCHf4L0Om/6yjJVwonB/nhuaCwAZj8AZ0u6hWqS8+tQQd
        9U0lP+LS24J0rg==
X-Received: by 10.99.230.83 with SMTP id p19mr1240186pgj.214.1496105577743;
        Mon, 29 May 2017 17:52:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id y5sm16484452pgb.4.2017.05.29.17.52.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 17:52:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Git List" <git@vger.kernel.org>
Subject: Re: mergetool: what to do about deleting precious files?
References: <8CEDDC40C7D24404976929CF3E7AF6FC@PhilipOakley>
        <xmqq37bpbx5t.fsf@gitster.mtv.corp.google.com>
        <D689F4F80DA24C78B5E0FB025B9548E6@PhilipOakley>
        <xmqqpoet9lms.fsf@gitster.mtv.corp.google.com>
        <DE497A69E68043DABF9C3A7D9198B277@PhilipOakley>
Date:   Tue, 30 May 2017 09:52:56 +0900
In-Reply-To: <DE497A69E68043DABF9C3A7D9198B277@PhilipOakley> (Philip Oakley's
        message of "Mon, 29 May 2017 13:57:08 +0100")
Message-ID: <xmqq1sr7f9nb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> If I now understand correctly, the merge process flow is:
>
> * canonicalise content (eol, smudge-clean, $id, renormalise, etc)
> * diff the content (internal, or GIT_EXTERNAL_DIFF)
> * apply the diff
> * if conflicts, only then use merge-driver/tool
>
> Would that be a correct interpretation?

Not quite.  There are a lot more going on before any of those steps:

 * Find the common ancestor commit (which could be many).

 * Walk the three trees (the common ancestor's, ours and theirs) in
   parallel, noticing what happened to each path.  Depending on what
   happened to the path in each branch, the merge may or may not
   "conflict" (e.g. when both sides added exactly the same contents
   to the same path, they are not counted as conflicting.  when we
   removed while they modified, they show as conflicting).

 * For paths that are conflicting, feed the canonicalized content of
   the versions from common, ours and theirs to the file-level merge
   driver.  The builtin file-level merge driver takes two xdiff (one
   between ancestor and ours, the other between ancestore and
   theirs) and reconciles them to produce the result.  But that is
   irrelevant in the context of "custom merge driver"; the builtin
   one is skipped altogether and the custom contents merge driver
   the user specified via the attributes is used instead.

Notice that the second step above has no customization knobs.  Any
path the second step deems not to conflict is "merged cleanly"
without even triggering the "oops, ours and theirs did conflicting
changes, to the content; let's see how the final content should look
like" (aka the third step).  This is *not* because "Git knows the
best"; it is merely that nobody felt the need for a mechanism to
allow customizing the second step.

And that is why I said you need a new customization mechanism if you
want to affect the outcome of the scenario that started this thread.
