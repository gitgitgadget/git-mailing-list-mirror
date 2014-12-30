From: David Renshaw <david@sandstorm.io>
Subject: bearer token authorization with HTTPS transport
Date: Tue, 30 Dec 2014 11:24:09 -0800
Message-ID: <CACejzECGUnH6B2Leq+H6u0Joo1SQmMCZ5UoHja_fK99+6a_iEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 20:24:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y62Ou-0003qs-Np
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 20:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbaL3TYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 14:24:11 -0500
Received: from mail-vc0-f171.google.com ([209.85.220.171]:41782 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbaL3TYK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 14:24:10 -0500
Received: by mail-vc0-f171.google.com with SMTP id hy4so5874077vcb.16
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 11:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to:content-type;
        bh=nZOXyqXW21qODRWpdUhchvzJvjqt9OSQxskkeknzJz8=;
        b=TObaEsLQNBcg3sZVZ1xa3Cno1JnGrC0QLqpZv083COp9KOTSoqs5CpDOP8Z0Aw5DDS
         Ex+/Cu0Hx6x6/kOXtOHZnKL0v/Q6fkt+vkSkUzjcT4cGeayUJWRD5FoCxyx6Dv0Pfyzp
         60iHVYhOi4RHQdXMcYd80aen3lT8a0CO7aLO8iQPemSAS5zrqds0RRNDWwwLhLYATK8m
         /OQISMvdo2oKnWQGRtqMmVvHP9RHnFkoyD+8PChubzvyu0Z5/BgwF091Mb3ubn0Bz/qe
         PPVX8UAIDpYGj3XXDX/6LlSl0Xz8KRlf98MhCnM4gQjDNWO6+uNk1Dyj6Rd/3ctAaCVf
         haew==
X-Gm-Message-State: ALoCoQnukh1MlW+Ppj8MGlHBpwGzXgE4F/ugqlTNSBOQGEfEAw1CjSw12FtOkQQyDidoeDLrKTBv
X-Received: by 10.220.251.79 with SMTP id mr15mr4200844vcb.20.1419967449746;
 Tue, 30 Dec 2014 11:24:09 -0800 (PST)
Received: by 10.52.180.232 with HTTP; Tue, 30 Dec 2014 11:24:09 -0800 (PST)
X-Google-Sender-Auth: oTuzDdnhA3MJPTWYmiIwlVkF_yQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261934>

Hi,
I would like to be able to serve a git repository over HTTPS from a
web server that requires OAuth2-style bearer tokens for authorization.
For more context, see this thread:
https://groups.google.com/forum/#!topic/sandstorm-dev/4oigfb4-9E4

Does anyone here have any advice about how to convince a git client to
add an "Authorization: Bearer <token>" header?

I can think of a few approaches:

(1) I could modify the curl remote helper to insert the header if it
sees a "bearertoken" config option. I have in fact written a
proof-of-concept patch that does this (see
https://github.com/dwrensha/git/commit/4da7b64b85b3b6652abe7), but I
don't know how much of chance something like this has of getting
merged into the mainline git client.

(2) I could write a new remote helper for, say, a "https+bearertoken"
transport. This seems like it would be more work than (1), but it
would also allow easier installation without interfering with the rest
of git.

(3) I could write a proxy server that inserts the header, designed to
run on the same machine as the client. This feels rather heavyweight.

Am I missing anything?

Thanks,
David
