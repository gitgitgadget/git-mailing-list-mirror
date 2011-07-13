From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [RFC/PATCHv2 3/6] commit: add commit_generation function
Date: Wed, 13 Jul 2011 10:26:19 -0400
Message-ID: <4E1DAB0B.4020109@gmail.com>
References: <20110713064709.GA18499@sigill.intra.peff.net> <20110713070517.GC18566@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 13 16:26:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh0OW-00035R-W0
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 16:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320Ab1GMO02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 10:26:28 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46908 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361Ab1GMO01 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 10:26:27 -0400
Received: by qwk3 with SMTP id 3so2881237qwk.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 07:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=o4OJ8bR16w8Q3t1AwQelDoLqdVVOqIe7YLJs+nnGSnQ=;
        b=NQ7hm7vq6+6bqFMl5akOy3puFBqoyunhvBDDsWzGJNDl1WrpsmdjasTK6dM9husMoE
         JsR2Z54TJ5Ca5DORY6SHPvY1FzvDNF9MXJsP3rlOFpdXVUHoelNPYxZHORjkznLvXnNg
         7mDKDQmw06f73rqKBQ6cQvgkdgNTgAIyjtX/Q=
Received: by 10.224.175.82 with SMTP id w18mr1072953qaz.125.1310567187291;
        Wed, 13 Jul 2011 07:26:27 -0700 (PDT)
Received: from [192.168.1.1] (user-0c936tj.cable.mindspring.com [24.145.155.179])
        by mx.google.com with ESMTPS id v4sm11943266qca.28.2011.07.13.07.26.22
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 07:26:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.0; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <20110713070517.GC18566@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177041>

On 7/13/2011 3:05 AM, Jeff King wrote:
> A commit's generation is its height in the history graph, as
> measured from the farthest root. It is defined as:
>
>    - Otherwise, its generation is 1 more than the maximum of
>      its parents generations.

Possessive: s/parents/parents'/

> We could also store generation numbers in the commit header
> directly. These would be faster to look at than an external
> cache (they would be on par speed-wise with commit
> timestamps). But there are a few reasons not to:
>
>    2. With grafts and replacement objects, the graph
>       structure (and thus the generation numbers) can be
>       changed. So the generation number, while immutable for
>       a given commit object, can be changed when we "lie"
>       about the graph structure via these mechanisms. Being
>       able to simply clear the cache when these things are
>       changed is helpful.

Would this be clearer? "Being able to rebuild the cache when..."

-- ES
