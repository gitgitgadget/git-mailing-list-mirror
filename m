Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E583620986
	for <e@80x24.org>; Fri,  7 Oct 2016 13:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756002AbcJGNNy (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 09:13:54 -0400
Received: from mail.javad.com ([54.86.164.124]:59554 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751939AbcJGNNw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 09:13:52 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 04EAF61059;
        Fri,  7 Oct 2016 13:13:46 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1bsUy8-0005r0-3k; Fri, 07 Oct 2016 16:13:44 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] Documentation/git-merge.txt: improve short description in DESCRIPTION
References: <cover.1475678515.git.sorganov@gmail.com>
        <e74ae8afc1bfc4cd9161ccaa56d926a89439551e.1475678515.git.sorganov@gmail.com>
        <xmqq60p6pt4k.fsf@gitster.mtv.corp.google.com>
        <871szuqyjo.fsf@javad.com>
        <xmqqa8eio4n9.fsf@gitster.mtv.corp.google.com>
        <87mvihpsla.fsf@javad.com>
        <xmqqshs9l69h.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 07 Oct 2016 16:13:44 +0300
In-Reply-To: <xmqqshs9l69h.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 06 Oct 2016 10:46:50 -0700")
Message-ID: <878tu0mhdj.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>>> Last, if "reference" is not good enough and we get to internals anyway,
>>>> why not say SHA1 then?
>>>
>>> Because that is still colloquial? I think s/name/object name/ is a
>>> sensible change, but not s/name/reference/.
>>
>> No, "reference" is more sensible here than any of "name", "object name",
>> or "SHA-1", the same way as here:
>>
>> $ git help glossary
>> [...]
>> chain
>>         A list of objects, where each object in the list contains a
>>         reference to its successor (for example, the successor of a
>>         commit could be one of its parents).
>> [...]
>
> The entry for "chain" and the description under discussion have
> stress on different aspect, though.  The description of "chain" is
> more general: an object refers to another object by referring to it,
> by unspecified means.  The reason why it is left unspecified is
> because the way a tree object refers to blobs and trees is different
> from the way a commit object refers to its parents (the former has
> object names of blobs and trees in the tree entries; the latter uses
> "parent" entries in the object header part to record object names of
> parent commits).  It wants to stress more on the fact that there is
> some mechanism to associate one object to others, than how that
> association/linkage is expressed.
>
> The way the resulting commit is described in the original text of
> "git merge" description stresses more on "how" by being a lot more
> specific to commit objects.  It does not just say "refers to parents
> (by unspecified means)"; instead it tries to say what exactly are
> recorded, i.e. the parents are referred to by recording the object
> names of them in a new commit object.  It stresses more on "how"
> (because it can afford to be more specific, unlike the description
> of more general concept of a "chain").

That's were our disagreement actually is, and that's what I've tried to
fix with s/name/reference/, and that's why I'm against s/name/object
name/.

Rather than being more (and more) specific at every opportunity, one
needs a good reason to get more specific. In this particular case,
general DAG terminology seems to be enough to describe git-merge
semantics, thus using GIT specifics is unfounded.

> It may be debatable if we want to give the description of what is
> exactly recorded at that point of the document,

Exactly. My point in this particular discussion is that details of
recording of references to parents don't belong here, even though to
tell the truth I think they don't belong to git _user_ documentation at
all.

> but I personally
> think that the users deserve a chance to learn how a merge is
> recorded in "git merge" documentation.

I doubt a user will gain anything from this sacred knowledge suddenly
being thrown on him when what she is looking for is understanding of
basic merge semantics in GIT.

That said, if you still disagree, please feel free to just drop the
patch.

-- Sergey
