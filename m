From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Tue, 30 Apr 2013 22:45:08 +0530
Message-ID: <CALkWK0nnmzV0dcZ9avO9zDPhnQh9wkF7stA77cNycoXfecfUuw@mail.gmail.com>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
 <87zjwguq8t.fsf@linux-k42r.v.cablecom.net> <20130430150430.GA13398@lanh>
 <7vehdsf19m.fsf@alter.siamese.dyndns.org> <CACsJy8B3PpzidvAHado=y3ZromzROidmHh_OW9ZCOoFegzmQ3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:15:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXE9m-0003Ng-14
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760868Ab3D3RPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:15:53 -0400
Received: from mail-ia0-f178.google.com ([209.85.210.178]:38256 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760860Ab3D3RPv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:15:51 -0400
Received: by mail-ia0-f178.google.com with SMTP id j38so641279iad.23
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=lU0/cFzvCuM63pFpuchjA59zbNHOYxgT7hgc6twAerc=;
        b=0EPVV1bno3hXmJmLzNFmJTRQd1K4z2aY+XChtBUU2gR4bSLoYKOapZO+GrruJjWAwD
         GGO79T7AI7lx0ZZiQMwLPeLzabiyM7TLMe4dni4TuuGdmFbVElFnD7u7eqsqDcMl3V1o
         uOG6NiNnz/6MtYa6EwhcSSrpi+BjdAo9UUd4VIIK13rrb2FjT6InSj75KTHsFuypIfLK
         tcClRGk3G/Y0jmUoIjnPBRdS9Eyb5nF3Kk8En+t5XnLWrnv/UUnzGHsRKM+IpatLluwV
         3UMsaryOdoRRcAkL3HVVOcJbDinLJX4rpN5qq1og9JiXcJ+6tQd1yQqVKXZhUfclnKGn
         U2Qg==
X-Received: by 10.50.57.200 with SMTP id k8mr10900917igq.44.1367342149159;
 Tue, 30 Apr 2013 10:15:49 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 10:15:08 -0700 (PDT)
In-Reply-To: <CACsJy8B3PpzidvAHado=y3ZromzROidmHh_OW9ZCOoFegzmQ3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222952>

Duy Nguyen wrote:
> We could put still ref aliases
> into the same ref namespace, with lower precedence that actual refs,
> so no new syntax required.

Actually, ref-alises are the right way to solve the problem.
Recursive symref peeling is a bad idea: I can't take my aliases with
me, and they complicate unnecessarily.

Any thoughts on how to implement it?  Should it go as deep as
resolve_ref_unsafe()?
