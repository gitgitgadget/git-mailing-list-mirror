From: Javier Domingo <javierdo1@gmail.com>
Subject: Fwd: Local clones aka forks disk size optimization
Date: Thu, 15 Nov 2012 00:42:00 +0100
Message-ID: <CALZVapmO61d8yXfXXGx6Qc444ka+8n7HabuNRt0rJdE5qy_7aQ@mail.gmail.com>
References: <CALZVapmG+HL0SQx8zx=Cfz5pWv84hJq90x-7VdjA0m2Z4dC34A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 00:42:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYmbM-00082R-Me
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 00:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992454Ab2KNXmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 18:42:22 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:64954 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754409Ab2KNXmV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 18:42:21 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so1082063vcb.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 15:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=GK1og+T0EzH1faLfJsTyMK2z+4A1O7btruYAwqi68Pk=;
        b=E0su1+JGbhzMk4zodGglEtezcoqjUSX5FHAtVW/6zHCja8ZxmjuhriJSotKtKGB+yr
         fhWaKSD6F75G2xwFykRQbiTOFk4cSsScWKjjZaeYMLmG5h28bfdi2LW2eIW4oSHGfLwZ
         +IYAaSQtPE65615gipn2RZ1lcKDFz0dhhPG28H3shu4LVpksmf/GtgIXS/4tXmpwzQFQ
         o/M8ymr950QRVEUweUnfj3jxqM7SqUqzJdkrSQZ6hTmtEsQQLodk8J0CjCI6hCmo+DC7
         sygsvTYl/Z/Nge+yVA+eX7XV0JIKvKfqXCUwXAfp66EzIiDuqxANDSYnEObldTZUqWNB
         TljA==
Received: by 10.52.71.44 with SMTP id r12mr4061191vdu.41.1352936540528; Wed,
 14 Nov 2012 15:42:20 -0800 (PST)
Received: by 10.58.33.200 with HTTP; Wed, 14 Nov 2012 15:42:00 -0800 (PST)
In-Reply-To: <CALZVapmG+HL0SQx8zx=Cfz5pWv84hJq90x-7VdjA0m2Z4dC34A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209758>

Hi,

I have come up with this while doing some local forks for work.
Currently, when you clone a repo using a path (not file:/// protocol)
you get all the common objects linked.

But as you work, each one will continue growing on its way, although
they may have common objects.

Is there any way to avoid this? I mean, can something be done in git,
that it checks for (when pulling) the same objects in the other forks?

Thought this doesn't make much sense in clients, when you have to
maintain 20 forks of very big projects in server side, it eats
precious disk space.

I don't know how if this should have [RFC] in the subject or what. But
here is my idea.

As hardlinking is already done by git, if it checked for how many
links there are for its files, it would be able to find other dirs
where to search. The easier way is checking for the most ancient pack.

Hope you like this idea,

Javier Domingo
