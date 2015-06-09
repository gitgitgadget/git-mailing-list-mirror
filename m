From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 1/9] tag: libify parse_opt_points_at()
Date: Tue, 09 Jun 2015 17:20:55 +0530
Message-ID: <5576D31F.90603@gmail.com>
References: <5573520A.90603@gmail.com>	<1433621052-5588-1-git-send-email-karthik.188@gmail.com> <xmqq4mmiauu0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 13:51:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2I4B-0001xI-CE
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 13:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932908AbbFILvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 07:51:10 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34278 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932843AbbFILvE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 07:51:04 -0400
Received: by pdbki1 with SMTP id ki1so13494006pdb.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 04:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9Nq//lyv2ZKpg/vJ31TMkRh8uoDMpY+JKAdodvdz0Zo=;
        b=vm7cK2KGJPmv6G/uGmA7iUUjLkgo6LgrMjMEGIRz4f6xZbZ+tGNINoLYrPilWOG4ug
         I6qvJcrC6eCzU5cJ9S7HAZKLPDpGExnHS5K+JgBRuA/3JEmJXHVjKlZLYQqf+5DqfbKX
         pVmtGovt4fFKafObbla+F9O3ajPqLwKqWukzoAyzhVqNTDE3409LljVqebvhwwZFleVw
         A2ceXJ+ynJxAEsZKtx2Dk6gd7MOhHcRPgNLpDbzVhPiJ5X6nImwN7MVi+8juJDYPvQgZ
         aDgpMsGOcwLVzh/3w3VPEhbcHh2hetEoM8pnNq8M26HFyyrsTXX8jEkq8UXOrF+5oevA
         MFqg==
X-Received: by 10.68.204.133 with SMTP id ky5mr38377292pbc.67.1433850661777;
        Tue, 09 Jun 2015 04:51:01 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id cf1sm5451381pdb.41.2015.06.09.04.50.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 04:51:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqq4mmiauu0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271165>

On 06/09/2015 12:30 AM, Junio C Hamano wrote:
>
> This feels way too specialized to live as part of parse_options
> infrastructure.
>
> The existing caller(s) may want to use this callback for parsing
> "points-at" option they have, but is that the only plausible use of
> this callback?  It looks to be usable by any future caller that
> wants to take and accumulate any object names into an sha1-array, so
> perhaps rename it to be a bit more generic to represent its nature
> better?
>
> 	parse_opt_object_name()
>
> or something?

This makes sense! Will change.

>
> I also wonder if we can (and want to) refactor the users of
> with-commit callback.  Have them use this to obtain an sha1-array
> and then convert what they received into a commit-list themselves.
>

But wouldn't that be too much of an overhead to iterate through the
sha1-array and convert it to a commit-list?

-- 
Regards,
Karthik
