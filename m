From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCHv6 1/2] repack: rewrite the shell script in C
Date: Thu, 22 Aug 2013 14:03:53 -0700
Message-ID: <20130822210353.GQ4110@google.com>
References: <5214F816.3010303@googlemail.com>
 <1377106096-28195-1-git-send-email-stefanbeller@googlemail.com>
 <xmqqfvu2u5io.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org,
	mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	mackyle@gmail.com, j6t@kdbg.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 23:04:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCc30-0002zs-6G
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 23:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312Ab3HVVD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 17:03:58 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34595 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196Ab3HVVD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 17:03:57 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so2400072pdi.14
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ia5ZWpqLmb0NjMVOM0UhMcbezQuDj6ac0Jxt/bC0fwo=;
        b=B/Vvx0ZoNZQHZYCeanhzlR0M5bPcyQkUIHKfvHCkRVyT5c5IOf/NJSgBSNyMm9R6Ho
         +MUFdv3LUrX5X9/nhbr6+9b/hgRBJ4wtGJekDKppS2/DT0we1ZwC92VyeMERV2aWcqNn
         Iz0cKO2QmBu9xR35RZ6SM1tsDkbe6TRbLg7BKNB3wOYOXogdlfINX/r6GqrS7aELmciE
         0naC9HjqrGKS3KqLMmZCbUw0VCVLT7LZ0UVfhv+dioDesEn540RNyPd9j500K3oLlHPZ
         UZwl6ySOR3GkPoKsqc/zT8lePNBc4fMpcJDa/UjIwWHSENOwwRILr0CCDGk6jSk8z3LF
         GnNg==
X-Received: by 10.68.130.2 with SMTP id oa2mr7380408pbb.134.1377205437279;
        Thu, 22 Aug 2013 14:03:57 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ht5sm16870721pbb.29.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 Aug 2013 14:03:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfvu2u5io.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232777>

Junio C Hamano wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:

>> The motivation of this patch is to get closer to a goal of being
>> able to have a core subset of git functionality built in to git.
>> That would mean
>>
>>  * people on Windows could get a copy of at least the core parts
>>    of Git without having to install a Unix-style shell
>>
>>  * people deploying to servers don't have to rewrite the #! line
>>    or worry about the PATH and quality of installed POSIX
>>    utilities, if they are only using the built-in part written
>>    in C
>
>I am not sure what is meant by the latter.  Rewriting #! is part of
> any scripted Porcelain done by the top-level Makefile, and I do not
> think we have seen any problem reports on it.
>
> As to "quality of ... utilities", I think the real issue some people
> in the thread had was not about "deploying to servers" but about
> installing in a minimalistic chrooted environment where standard
> tools may be lacking.

Thanks for a sanity check.  Yeah, the second item should be about
minimal chroots, not my sloppy guess about some hypothetical bad
operating system with untrustworthy tools.

Jonathan
