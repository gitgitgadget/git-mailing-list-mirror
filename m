From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: t3010 broken by 2eac2a4
Date: Thu, 22 Aug 2013 18:53:07 -0400
Message-ID: <CAPig+cQ15Qq7pJ0sLmnuQt_EERn9fkzCa-Gr-pb6a_zf1MLcGQ@mail.gmail.com>
References: <82078845-3AB9-4B36-9130-039CC33C8A7A@gernhardtsoftware.com>
	<xmqqbo4qu3g4.fsf@gitster.dls.corp.google.com>
	<CAPig+cQHTvmTWvGfg1Z3KfBrPD+QbSEbYBYz6XWT3KKu3-+jyQ@mail.gmail.com>
	<xmqqbo4pqvde.fsf@gitster.dls.corp.google.com>
	<CAPig+cQmvRDDc3BHbta_UhCQe9QvbtAm0RJgt6HbtgFAKgo0Vg@mail.gmail.com>
	<xmqq7gfdqumd.fsf@gitster.dls.corp.google.com>
	<CAPig+cSEQLk2M+X5QP7mkm846wqqHRCjPHgO7O3URvNcsYO6+w@mail.gmail.com>
	<xmqq38q1qu3l.fsf@gitster.dls.corp.google.com>
	<CAPig+cSgM-kO0Mk9qbGfLR8DZkYQt60Va4N2wfRBVqmReTPowQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 00:53:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCdkf-000821-NB
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 00:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968Ab3HVWxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 18:53:09 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:49679 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648Ab3HVWxI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 18:53:08 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so4861144oag.13
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 15:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SB+0fJv/JHRFlz3Mu4surzqYEE+9HYt011x5rSGVd2s=;
        b=zPqEPu8H0RXva0NZxXA9u2CrMM4BKEs0nGhC5wDFMQCN1tEVnZwx3fN1bdNnnqshEZ
         ExU/Ol77KeQ6KmU5+aDWN/9GM6/bf/VHu5QpgJCwfo9K8KB84TDAPhweZeEpsfSw5rv2
         Xwoljcs9BIWFKPYA/8dOBHRkXrWTWDyWxwDbYT4CYXzgID6GD2g4fixy9i1w4ma+S1Yo
         D0Y1Cr9Cqflo8vZePRGB2NGKY1BzfHC4w3zPvOcPc+HCYDSsOAsC5eN5y2936rX7m8I3
         CA7EvF+3ZGMiwCPq5F2IVdGXYedjWh1dL1Eoz3BC3p08uZrXSntPoV2BR2hF/yK5EBs7
         lU/Q==
X-Received: by 10.182.51.132 with SMTP id k4mr4027275obo.101.1377211987643;
 Thu, 22 Aug 2013 15:53:07 -0700 (PDT)
Received: by 10.182.224.167 with HTTP; Thu, 22 Aug 2013 15:53:07 -0700 (PDT)
In-Reply-To: <CAPig+cSgM-kO0Mk9qbGfLR8DZkYQt60Va4N2wfRBVqmReTPowQ@mail.gmail.com>
X-Google-Sender-Auth: 5iKke6X-vWETFXr_UkfkzdO8YDE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232784>

On Thu, Aug 22, 2013 at 5:59 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Aug 22, 2013 at 5:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> On Thu, Aug 22, 2013 at 5:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Now, I am curious how it breaks on OS X.
>>>>
>>>> My suspition is that "ignore_case" may have something to do with it,
>>>> but what 2eac2a4c (ls-files -k: a directory only can be killed if
>>>> the index has a non-directory, 2013-08-15) uses are the bog-standard
>>>> cache_name_exists() and directory_exists_in_index(), so one of these
>>>> internal API implementation has trouble on case insensitive
>>>> filesystems, perhaps?  I dunno.
>>>
>>> That's exactly my suspicion at the moment. It's an obvious difference
>>> between Linux and OS X. I'm just in the process of trying to compare
>>> between the two platforms.
>>
>> Or perhaps de->d_type does not exist?  In such a case, we end up
>> doing get_index_dtype() via get_dtype(), but in this codepath I
>> suspect that we do not want to.  We are interested in the type of
>> the entity on the filesystem.
>
> de->d_type exists on both platforms. get_dtype() is never called.
>
> However, I did discover that treat_path() is being invoked fewer times
> on OSX than on Linux. For instance, in the repository created by
> t3010, treat_path() is called 19 times on Linux, but only 17 times on
> OSX.

Status update: For the 'pathx' directory created by the t3010 test,
directory_exists_in_index() returns false on OSX, but true is returned
on Linux.
