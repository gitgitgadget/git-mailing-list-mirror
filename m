From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: support the rel=vcs microformat
Date: Wed, 7 Jan 2009 19:03:04 +0100
Message-ID: <cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com>
References: <20090107042518.GB24735@gnu.kitenet.net>
	 <gk2794$djn$1@ger.gmane.org> <20090107155023.GA16540@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Joey Hess" <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Jan 07 19:04:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKcle-0001X9-8a
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 19:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbZAGSDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 13:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366AbZAGSDJ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 13:03:09 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:62536 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbZAGSDG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 13:03:06 -0500
Received: by ewy10 with SMTP id 10so9159675ewy.13
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 10:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Wo4cyzppiN+gKm47aXQSt/O+LuxCIgEkiivLEy5UW7A=;
        b=Ia2TQVjJP3XhGPmqwXDaydQWEH/NbDhjKMytBWIgvd1xEybncgVCM5aR9yFKIVVk1b
         +e2CVRFGPZao0DMxFznRu5cprKPflqLnF0DAapxZOvLtmKUuyINr0juRLvCiey/PrsWY
         ee6AxFSMNWGrf58XWVYUXZOVgxQZdWXRPHy1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=RFAs3L2aVAjPjJjb2J0ngi+u4QUVYogbdIvp/e/HWxXntLOa+vk5G/O3rZeCuLkIxt
         RYeBPD99aKNccuzeg0h92nZxq4mxLsUDnYNJ42a4nm4D1o6PnFMrJNPI3nSsjSG95vSJ
         nmq3cT/JNGO5RG2tJEuhFgXPoAjWmyXkRT9GY=
Received: by 10.210.87.19 with SMTP id k19mr1887570ebb.141.1231351384868;
        Wed, 07 Jan 2009 10:03:04 -0800 (PST)
Received: by 10.210.57.20 with HTTP; Wed, 7 Jan 2009 10:03:04 -0800 (PST)
In-Reply-To: <20090107155023.GA16540@gnu.kitenet.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104814>

On Wed, Jan 7, 2009 at 4:50 PM, Joey Hess <joey@kitenet.net> wrote:
> Giuseppe Bilotta wrote:
>> In this patch you do NOT add titles to the rel=vcs links, which means that
>> everything works fine only if there is a single URL for each project. If a
>> project has different URLs, it's going to appear multiple times as _different_
>> projects to a spec-compliant reader.
>>
>> A possible solution would be to make @git_url_list into a map keyed by the
>> project name and having the description and repo URL(s) as values.
>
> Yes. I considered doing that, but didn't immediatly see a way to get the
> project description w/o additional overhead (of looking it up a second
> time).

The solution I have in mind would be something like this: in summary
or projects list view (which are the views in which we put the links,
and also the views in which we loop up the repo URL and the
description anyway), you fill up former @git_url_list (now
%project_metadata) looking up the repo description and URLs. You then
use this information both in the link tag and in the appropriate
places for the visible part of the webpage: you don't have a
significant overhead, because you're just moving the project
description retrieval early on.

You probably want to refactor the code by making a
git_get_project_metadata() sub that extends the current URL retrieval
by retrieving description and URLs. The routine can then be used
either for one or for all the projects, as needed.

> Thanks for the feedback. There are some changes happening to the
> microformat that should make gitweb's job slightly easier, I'll respin
> the patch soon.

Let me know about this too, I very much like the idea of this microformat.

-- 
Giuseppe "Oblomov" Bilotta
