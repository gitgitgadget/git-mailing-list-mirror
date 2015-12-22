From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: "git stash pop" is doing an unwanted "git add" when there are
 conflicts.
Date: Tue, 22 Dec 2015 09:17:38 +0100
Message-ID: <1450772258.7937.9.camel@kaarsemaker.net>
References: <20151221142953.GA12764@acm.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Alan Mackenzie <acm@muc.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 09:17:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBI8g-0006g6-9V
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 09:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbbLVIRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 03:17:42 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33960 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbbLVIRm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 03:17:42 -0500
Received: by mail-wm0-f53.google.com with SMTP id l126so98659432wml.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 00:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:content-type
         :mime-version:content-transfer-encoding;
        bh=RUHlLl+ChwvfZXF6YlofAQ0eUHJH+mQbFOqkIsCYatw=;
        b=Wwm6MqH6bkcsBVi8x+qEBYXW1/JZRzEnqN0h/feJwbpp+JYAHdaWVK3wsIXMo+c+Zb
         GwGuJNyZTOdGkZ3yODM8GOHQStGX8qL85hp+0zInuOyKDOyK09MEwC4pePocAGc4Pw1z
         C0fgnCtQpFYkaGEsm5qOsNjAW5gncApYsaZQZeNPZgKkDivwAj5MOIMLAQdd0oB+gm7P
         UVXKAK0dXs3qh52CK+7K7A37cEQXfT0GcMFr6pzXLwODj7lxpB3oOhXDIz/qY5xXYMMV
         p3cCk9UaIfteUe3XL7B8BMupyyLwI5FSB63OxwdfRd9gAD9enyN5AEX8bTpzpsJF6Eyd
         5VdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=RUHlLl+ChwvfZXF6YlofAQ0eUHJH+mQbFOqkIsCYatw=;
        b=Ukztz5fgk60lZlMyGsWrfU2BlxGhrkw9/qPr/M93V/1BR7uoOFqnkwzkYJWYZY5QiI
         3N3JXavEF+Fc/bpMD5EpGucxZW8kBWAnJYcWFAe497RdefcnKzQ4qTAugE+K3jY9LK71
         hSfs54iJpn8QItf3hJu8o4mJ3RJaUBrHoZ4k7L8ChYnJfqIZIB3YsD7poapOOLYIzS3W
         410EFHhjBEqQdpEbyZFVLRkkvDHEVcnEQyU+A5xnXMuiORqZZXhD4QoHryO9+OtSsksA
         ngA10Ewg2NnCeJWSCyohtOM6PxGMQ0NxXsOE4sd6RnYAHljnlczwxoYaxwjT0mhazjhF
         Pw2A==
X-Gm-Message-State: ALoCoQk4HPj1cWL4Oclbj0C4vPRqAQfu4ldZy1qS/lf4AGmDhbN0AlVBAbhUUj+W8Ngk8sBHcQkayUczqnIeJbmbgFnB94M6tw==
X-Received: by 10.28.156.213 with SMTP id f204mr24895971wme.57.1450772259789;
        Tue, 22 Dec 2015 00:17:39 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id id1sm31178672wjb.19.2015.12.22.00.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2015 00:17:38 -0800 (PST)
In-Reply-To: <20151221142953.GA12764@acm.fritz.box>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282834>

On ma, 2015-12-21 at 14:29 +0000, Alan Mackenzie wrote:
> Hello, git project.
> 
> Last night, whilst clearing out a stale "stash stack", I did "git stash
> pop".  There were conflicts in two files.
> 
> However, all the popped files became staged.  This doesn't normally happen.
> It was intensely irritating, and required me to do "git reset HEAD" on
> each of the files, none of which I wanted to commit.
> 
> I searched the git-stash man page for this scenario, but found nothing
> about it.
> 
> Surely staging all the files is a bug?

That depends. A stash is two commits: one for all changes that were in
the index when you ran 'git stash save' and one for all changes not yet
in the index. When you pop the stash, these then get restored as staged
resp. unstaged changes. So if your changes are now all staged, I'd
wager that they were staged when you ran git stash save.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
