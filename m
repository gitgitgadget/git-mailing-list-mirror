From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow to control the namespace for replace refs
Date: Thu, 11 Jun 2015 08:16:02 -0700
Message-ID: <xmqq1thigtsd.fsf@gitster.dls.corp.google.com>
References: <1433987235-17385-1-git-send-email-mh@glandium.org>
	<xmqqlhfqhmil.fsf@gitster.dls.corp.google.com>
	<20150611051339.GA3637@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jun 11 17:16:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z34DD-00076J-23
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 17:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbbFKPQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 11:16:07 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:34396 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbbFKPQF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 11:16:05 -0400
Received: by igdh15 with SMTP id h15so2309797igd.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=PqLCtyGWhHjqtbtHJtWH6oANa6JkHVXXkzangBGVr4U=;
        b=SpdKWcs5Z/qe9+rI3jHRDnI9JHxTZkLHYH2sIktAzO74irhud5FnQy+jDDEGpTc/y9
         iAM1lqTFLzXK3s2TD6JC9K+wE4DuZJ9kpKYBj5FqCtIfi7T2bw4YIZLv1AY4F5llpf4I
         RStqCbImV1mZ27tHOJiSc0F/HL4aYxggxFK5YSScRRtAm7Hror/0+lpV78V52wIKNeqH
         ZhABVOlio+hlaxlzHGiQECfAeT8QIK9ZvhBYeo04ezvaCliGPxKKNE17ljyaim3Jk2b7
         Y51uuYaZI0dRDeboXVatUC0vu2i9ncUSoo9HNxnml2A8kxkSnBuRPExpdCijxwBbrXpy
         +XZw==
X-Received: by 10.50.6.76 with SMTP id y12mr13712308igy.31.1434035764520;
        Thu, 11 Jun 2015 08:16:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id o9sm540327ioe.35.2015.06.11.08.16.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jun 2015 08:16:03 -0700 (PDT)
In-Reply-To: <20150611051339.GA3637@glandium.org> (Mike Hommey's message of
	"Thu, 11 Jun 2015 14:13:40 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271416>

Mike Hommey <mh@glandium.org> writes:

> I do agree that this is all confusing, but allow me to point out that
> it's already plenty confusing: "namespace" is a term that has been used to
> designate a generic kind of namespace *and* refs/namespaces. See for
> example:
>
> https://github.com/git/git/blob/master/Documentation/git-describe.txt#L39
> https://github.com/git/git/blob/master/Documentation/git-fetch.txt#L113
> https://github.com/git/git/blob/master/Documentation/git-filter-branch.txt#L36
> (note how this one is specifically about refs/replace/)
> there are many more.

"One more breakage does not hurt" is not something we want to see.

> _REF kind of implies _one_ specific ref....

I thought about suggesting GIT_REPLACE_REFS for that exact reason,
but decided against it, because (1) if you are using replace, then
you know you are not using a single ref but a group of refs in a
single hierarchy already, and (2) if you do not know what replace
and notes are, GIT_REPLACE_REFS and GIT_NOTES_REF look just being
inconsistent (even though the intention of the difference is to be
more logical).  s/S/_BASE/ would make that better, though.

> As for exposing a pref, I'm not entirely sure it makes sense to.

I don't see an immediate need for it, and it is easy to add later,
so let's limit the scope of the initial adoption of the feature.

Thanks.
