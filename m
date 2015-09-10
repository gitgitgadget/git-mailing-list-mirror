From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v17 05/14] ref-filter: introduce match_atom_name()
Date: Thu, 10 Sep 2015 10:45:04 -0700
Message-ID: <xmqqd1xq419b.fsf@gitster.mtv.corp.google.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<1441900110-4015-6-git-send-email-Karthik.188@gmail.com>
	<xmqq37ym5i2u.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQM77+EzbHbY24nvu=hgNCa9MJ3wyz1XhFjk+3HdDd_Hg@mail.gmail.com>
	<xmqqlhce420b.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQXP-U+dGYYFcvxVmuG2NOSiHYLHEwm2OtvhGQrBW9hdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 19:45:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za5uN-0001Z2-3K
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 19:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbbIJRpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 13:45:11 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35779 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbbIJRpK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 13:45:10 -0400
Received: by pacfv12 with SMTP id fv12so49901300pac.2
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 10:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lQ4cWCxm8EO3fYUnwxukXAQf6b3dFI7m3StXsHdY1ps=;
        b=EMr+DajlZaws4Er/VX5MG+Qt1qV2/UZz9GQsZnlgemLJ3sfxjXD9QUgabW3MhKQa6b
         4q3pibARezyaU/4Vgp7/IbdOJFctZB1gs7u3tIZYyvssnKqjIxN4DnVkWkT3ZDxVa3pa
         13rGGkyPXVDov3YwIBOcgo+6iw4topRsrVfsKXqXiYhLdBxTkKnA9KJhMtoFyXXDQkN4
         yLlSdbgYYokoxBVp+zJcIglgEI93n09SaKpvP4w7yW1qdpNJlbwfNee2BVeIpBY1zixA
         TrNWrn2VCCRGZytUj3bEep9DuiTWAOLV6PDeQfi3vAYVjnwDohKSpdCn5NmtNmTcjfzF
         o43Q==
X-Received: by 10.68.69.17 with SMTP id a17mr85858903pbu.10.1441907109434;
        Thu, 10 Sep 2015 10:45:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8419:5a5:3940:dfa0])
        by smtp.gmail.com with ESMTPSA id fu4sm13179429pbb.59.2015.09.10.10.45.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Sep 2015 10:45:05 -0700 (PDT)
In-Reply-To: <CAOLa=ZQXP-U+dGYYFcvxVmuG2NOSiHYLHEwm2OtvhGQrBW9hdQ@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 10 Sep 2015 23:05:48 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277615>

Karthik Nayak <karthik.188@gmail.com> writes:

> It is one thing that the user can actually do the check themselves,
> but doesn't it make more sense that when we're using colon we expect a
> value after it, and something like %(color:) makes no sense when color
> specifically needs a value after the colon.

If you imagine the format being built by scripts (we are talking
about plumbing feature --format here), I think you will realize that
it perfectly makes sense to allow them to say "%(atom:$modifiation)"
without having to worry about a special case where $modification
happened to end up being empty.  So no, I do not agree with your
statement at all.
