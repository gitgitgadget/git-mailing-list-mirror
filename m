From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] upload-pack: Remove a piece of dead code
Date: Thu, 11 Jul 2013 08:49:20 -0700
Message-ID: <7vy59drta7.fsf@alter.siamese.dyndns.org>
References: <20130711105733.GG10217@login.drsnuggles.stderr.nl>
	<1373541954-16493-1-git-send-email-matthijs@stdin.nl>
	<CACsJy8CazcJau0yTYSndbam_bUhZLS5f02p9WD0jjutHh1J6+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthijs Kooijman <matthijs@stdin.nl>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 17:49:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxJ7d-0004Dx-Un
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 17:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216Ab3GKPt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 11:49:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60578 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932137Ab3GKPt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 11:49:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 420562FCF1;
	Thu, 11 Jul 2013 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hCe6ELN5CEp9rtgMFxkqSvD9/Zg=; b=W4J0J0
	bQe+B/+aU+bD9vD842VU3fjIkQX55M17wkS2j9HW+7fQ7rUgGQUl3LAVDur73nxI
	vt40Mcmf5KbhrRo1lPyNVJbowga7KKIJ9LZHMMS0DQyYxvF1NJlJUQNHRShFBVWm
	3wR58h1uSLx9HznHjkm0wqnuz4CamFKW5hNb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uQHs6XAuxTSOzGAAtJ1kLCIbfHumj7eZ
	lxB2R/XWIXkv0baAy2u2T/reWU12rO+cCI+s+dkfGhptvC4NMPB8ck18vOTO3ndW
	jtqOjqWE+l2CtJ5GdXgWN6TbrIHwTiGV/34MYs+oDkDSNoV0vX533ybi0WU+aiJ1
	YHOtSa7hFx4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B63C2FCE9;
	Thu, 11 Jul 2013 15:49:26 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F2492FCCF;
	Thu, 11 Jul 2013 15:49:23 +0000 (UTC)
In-Reply-To: <CACsJy8CazcJau0yTYSndbam_bUhZLS5f02p9WD0jjutHh1J6+A@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 11 Jul 2013 19:08:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 755230DE-EA41-11E2-82E8-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230109>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Jul 11, 2013 at 6:25 PM, Matthijs Kooijman <matthijs@stdin.nl> wrote:
>> Commit 682c7d2 (upload-pack: fix off-by-one depth calculation in shallow
>> clone) introduced a new check in get_shallow_commits to decide when to
>> stop traversing the history and mark the current commit as a shallow
>> root.
>>
>> With this new check in place, the old check can no longer be true, since
>> the first check always fires first. This commit removes that check,
>> making the code a bit more simple again.
>
> True. Ack-by: me.
>
>> Signed-off-by: Matthijs Kooijman <matthijs@stdin.nl>

Yeah, thanks both.  I tend to agree that 2 and 3 are the right
change that came too late after the ship sailed X-(.

>> ---
>>  shallow.c | 17 ++++++-----------
>>  1 file changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/shallow.c b/shallow.c
>> index cbe2526..8a9c96d 100644
>> --- a/shallow.c
>> +++ b/shallow.c
>> @@ -110,17 +110,12 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
>>                                         continue;
>>                                 *pointer = cur_depth;
>>                         }
>> -                       if (cur_depth < depth) {
>> -                               if (p->next)
>> -                                       add_object_array(&p->item->object,
>> -                                                       NULL, &stack);
>> -                               else {
>> -                                       commit = p->item;
>> -                                       cur_depth = *(int *)commit->util;
>> -                               }
>> -                       } else {
>> -                               commit_list_insert(p->item, &result);
>> -                               p->item->object.flags |= shallow_flag;
>> +                       if (p->next)
>> +                               add_object_array(&p->item->object,
>> +                                               NULL, &stack);
>> +                       else {
>> +                               commit = p->item;
>> +                               cur_depth = *(int *)commit->util;
>>                         }
>>                 }
>>         }
>> --
>> 1.8.3.rc1
>>
> --
> Duy
