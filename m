From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] cache-tree: Write updated cache-tree after commit
Date: Mon, 07 Jul 2014 17:26:41 -0700
Message-ID: <xmqq7g3obsqm.fsf@gitster.dls.corp.google.com>
References: <1404619619-4774-1-git-send-email-dturner@twitter.com>
	<1404619619-4774-4-git-send-email-dturner@twitter.com>
	<xmqq61j9c4xb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 02:26:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4JFK-0003Ya-0b
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 02:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbaGHA0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 20:26:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50371 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754933AbaGHA0t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 20:26:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6971927DBB;
	Mon,  7 Jul 2014 20:26:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h25JOvAMqAgJwbA9Mc9HSK5gCsY=; b=QI8W2F
	+GXbdcj8tytcNSXmfQR2KV7esJhqZQ4Uw0gWPhfhKt56tPhcj4Au8vRrGIf3kIod
	9sPVnTYeXNIxpPqumlxy2jq2DC/Hqv2pD5QTKYUf4/DsQ9DbhteMh4JZdfyCUTVv
	eg/mVnW9wiUKEa9gpTFSDYsQCmHIP7xe7JVgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mznc/yKVL3uaxY6KEakMMsKLJTTnGS4G
	6rIrn1Z9f1v/ns6q+5jRFkJW+73i5UjourqjjbDRunpehQdJpyDGFf/XcjAhv4eb
	CGJ4nkqh03ayq1JCbrJHHgwxgi7clOpfXtkDMus449WqjKDYr4rJ2RvcgCrUF78j
	razxt6gB+Do=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5BDE727DBA;
	Mon,  7 Jul 2014 20:26:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4AA4E27DB3;
	Mon,  7 Jul 2014 20:26:30 -0400 (EDT)
In-Reply-To: <xmqq61j9c4xb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 07 Jul 2014 13:03:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 81C574A4-0636-11E4-A2D7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252996>

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 9cfef6c..5981755 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -342,6 +342,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
>>  
>>  		discard_cache();
>>  		read_cache_from(index_lock.filename);
>> +		if (update_main_cache_tree(WRITE_TREE_SILENT) >= 0)
>> +			write_cache(fd, active_cache, active_nr);
>>  
>>  		commit_style = COMMIT_NORMAL;
>>  		return index_lock.filename;

I'll push out a tentative result of merging this series (with some
proposed fix-ups) sometime later today, but this part interacts with
Duy's split-index topic in a funny way, so I'd exclude it from the
merge result for now.

Thanks.
