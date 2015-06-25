From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] git-reflog: add create and exists functions
Date: Thu, 25 Jun 2015 11:35:17 -0700
Message-ID: <xmqq381fzlei.fsf@gitster.dls.corp.google.com>
References: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
	<1435173388-8346-6-git-send-email-dturner@twopensource.com>
	<xmqqioabzoz2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 20:35:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Bzj-0003ae-Ti
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 20:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbbFYSfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 14:35:22 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:36070 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbbFYSfU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 14:35:20 -0400
Received: by iecvh10 with SMTP id vh10so60557861iec.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 11:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mVhIm2WlK/rnzHizDnWTd9xhUafitmWHwQ/R8vFNsRQ=;
        b=U3KpaWj5O4DSoRdgsJlWMjf0jXgS3Xef3d6EY9fhvgIfds6CxV0cqjyxYqnF02ht/j
         2cNAeQW4NiTjR3jpwRMfWbtfTNitteGbCSmKnoXXk4XV4qL/WqZ7FEIrvv77xbFc0Oc7
         1Bu/LKazfx76kzsfPDkB0E6zKmAKgtlrW85ZWN8Hx+0cvSZUN0WdH+eu8HIx0YIMG60k
         AQ6fVhjwbIeOgsUy3K1q/O3mr9ltpalnvyKdwcAnLOiJMEmSSQ3WdW3lNKMiM5WrfzDe
         TEhfboKt7NoqK/1IMcVOiLxZY/hLETt9irQKK8dNsuFR+kt+7IyxXt78vOtOFFChvUUr
         V0AA==
X-Received: by 10.42.255.200 with SMTP id nj8mr44221812icb.18.1435257319586;
        Thu, 25 Jun 2015 11:35:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id c12sm18347315ioj.39.2015.06.25.11.35.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 11:35:19 -0700 (PDT)
In-Reply-To: <xmqqioabzoz2.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 25 Jun 2015 10:18:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272706>

Junio C Hamano <gitster@pobox.com> writes:

> Now, going back to 4/6, I think create_reflog() function as an
> external API has a few problems.
>
>  * Its name does not tell us what should happen when a reflog
>    already exists for the refname the caller asked to "create"
>    reflog for.  I understand that this only makes sure it exists and
>    does not destroy existing one.  Its old name, log_ref_setup(),
>    did not have this problem, but now it does.
> ...
>  * Add a thin-wrapper for callers that do not care about the path to
>    the log file, e.g.
>
> 	int vivify_reflog(const char *refname, struct strbuf *err)
> 	{

As usual, I am aware that I am not good at naming things (but I can
tell when somebody uses a bad name), and "vivify" may be a horrible
name for that.  A reroll with a better name is very much welcomed.

Perhaps prepare-reflog?  I dunno.
