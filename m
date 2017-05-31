Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1724D2027C
	for <e@80x24.org>; Wed, 31 May 2017 00:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750954AbdEaACk (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 20:02:40 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33613 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdEaACj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 20:02:39 -0400
Received: by mail-pf0-f172.google.com with SMTP id e193so1273640pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 17:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=s9dEP+YXWyE5LLukQ0vaTy7gFHfze6UhdupBsYim3Ko=;
        b=Gb+ncLgC01D38WNAVnAikf5jZkhJUsMfUTNWmmoG813EWUX63f8/GVxVIvtJaiumNN
         gRtiRCPBoWHhQQpQ6jYxRm8pIcapcnmO3JSHkrxzaoE5YgesiCIxcG1yKq9dDibiRe3p
         Eq8VwiD8WO4aATjYXXefSSki6jIASDGhFpXPd1w58N8trVH3Y3lmCRR3YP3dkzKl7bsD
         dtQcmELv0dxILFHxy+2v0i/7e9YwcEJCrFtoEi+dhX/OGxXXvg7ykKmnBnstjoGyPsQ3
         8ZYypKowf56haTy6tiQFihvwuY3E91vAR91pZYnB3l/h67/rUd9qXmSmOR6FKgqr6LGR
         dcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=s9dEP+YXWyE5LLukQ0vaTy7gFHfze6UhdupBsYim3Ko=;
        b=dS2OIyDOv53wVB+JUy0iviP/40UGDRDSkR3LDce1opSMQhVX0TmXqhe10afXIaNouQ
         aIgOTh7GveJzfRzI7gnVozm1wy7g59adI7xWBUX9h/ehaM2ZsJvXx9zvN9SFqBJvZfwn
         QSE/pxWFM4oJaZB4YeoetUuW66w/zyZEx1gslDjuMGG7euLGveCIMJJ1iNh7HmtCKwfK
         SiYJbIxR+xmejzx0hgZWt9jMBxIzWnn0SztEf5XxqbWHKOewi7iRdpRnLk3PSczLMy63
         NBSA87SwINbuOHaZrD82eAme/uU33DnzjtTWKktcfsl/Y/Lk5OFRd1pFRkDMpdNs2h1A
         o1pg==
X-Gm-Message-State: AODbwcCRHGBJCbTCTMbv61cyDoYQ1xODZ5Lu+juTW407z2PJclqYGUFW
        l+5DFnI3v3qOYikU3Nk=
X-Received: by 10.98.145.26 with SMTP id l26mr26635978pfe.36.1496188958871;
        Tue, 30 May 2017 17:02:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d156:5238:7809:132c])
        by smtp.gmail.com with ESMTPSA id k86sm23920833pfk.125.2017.05.30.17.02.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 30 May 2017 17:02:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Git List" <git@vger.kernel.org>
Subject: Re: mergetool: what to do about deleting precious files?
References: <8CEDDC40C7D24404976929CF3E7AF6FC@PhilipOakley>
        <xmqq37bpbx5t.fsf@gitster.mtv.corp.google.com>
        <D689F4F80DA24C78B5E0FB025B9548E6@PhilipOakley>
        <xmqqpoet9lms.fsf@gitster.mtv.corp.google.com>
        <DE497A69E68043DABF9C3A7D9198B277@PhilipOakley>
        <xmqq1sr7f9nb.fsf@gitster.mtv.corp.google.com>
        <E0D5AC60DB0F48DEBF865597910D9531@PhilipOakley>
Date:   Wed, 31 May 2017 09:02:35 +0900
In-Reply-To: <E0D5AC60DB0F48DEBF865597910D9531@PhilipOakley> (Philip Oakley's
        message of "Wed, 31 May 2017 00:04:46 +0100")
Message-ID: <xmqqbmq9ao6c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>
> Thanks for the replies. Let's see if I've got it...
>
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>> If I now understand correctly, the merge process flow is:
>>>
>>> * canonicalise content (eol, smudge-clean, $id, renormalise, etc)
>>> * diff the content (internal, or GIT_EXTERNAL_DIFF)
>>> * apply the diff
>>> * if conflicts, only then use merge-driver/tool
>>>
>>> Would that be a correct interpretation?
>>
>> Not quite.  There are a lot more going on before any of those steps:
>>
>> * Find the common ancestor commit (which could be many).
>
> IIUC Git selects one of them, rather than all if there are many (which
> then may not be the optimum)

Not quite.  The interface to "git merge-$backend" can take more than
one and "git merge" frontend does pass them to the backend.  How
they are used depends on the backend.  The "resolve" one tries to
use all of them at once; the "recursive" one tries merge across them
to come up with a tree to be used as a single "virtual common
ancestor".  But details does not matter for the purpose of analysing
the case that triggered this discussion.

>>
>> * Walk the three trees (the common ancestor's, ours and theirs) in
>>   parallel, noticing what happened to each path.  Depending on what
>>   happened to the path in each branch, the merge may or may not
>>   "conflict" (e.g. when both sides added exactly the same contents
>>   to the same path, they are not counted as conflicting.  when we
>>   removed while they modified, they show as conflicting).
>
> I'm assuming here that this is the sha-oid comparison, and then
> checking the tree/blob names that match them. (the top tree not having
> a name). So here "conflict free" is that the sha-oids match.
>
> Also, I thnk this is saying that added or removed trees or blobs are
> in some sense are 'conflict free' (though still subject to rename/move
> detection etc). An added file/blob would be conflict free for merging
> into it's tree, yes?

After "recursive" figures out the renames, an addition that still
remains (i.e. not matched up with a deletion elsewhere) would be a
candidate to be added silently (except that D/F conflict can still
be diagnosed).

>> * For paths that are conflicting, feed the canonicalized content of
>>   the versions from common, ours and theirs to the file-level merge
>>   driver.
>
> So this is where any .gitattibutes settings come in, or is the merge
> driver after the diff step? (which could also be a user diff?)

I think you answered this yourself in your "Ok, I think I can see
how I was confused..." paragraph.
