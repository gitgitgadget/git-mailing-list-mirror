From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit 5841520b makes it impossible to connect to github from behind my company's firewall.
Date: Tue, 20 Oct 2015 09:11:21 -0700
Message-ID: <xmqqr3kp8qqe.fsf@gitster.mtv.corp.google.com>
References: <loom.20151020T131513-529@post.gmane.org>
	<vpq37x54vav.fsf@grenoble-inp.fr>
	<cbf2c2c2c137445ebb9e2c5f1012cb10@EXMBNJE8.ad.twosigma.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: 'Matthieu Moy' <Matthieu.Moy@grenoble-inp.fr>,
	Johan Laenen <johan.laenen+cygwin@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Enrique Tobis <Enrique.Tobis@twosigma.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 18:11:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoZVY-0001AW-TS
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 18:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbbJTQLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 12:11:25 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33443 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbbJTQLY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 12:11:24 -0400
Received: by pabrc13 with SMTP id rc13so25498097pab.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=l0pm1h6YYV7Mqe+a7/4OhyPL5dkxt/7/Q686/B/A/AM=;
        b=hCJzDnRHveAxGMgcuMLsHKp++LwQjb+8RlxUsfWDuaxd1yqzj/3OCBvJzbf49d6kfv
         0HHzS0y/s3GYS7Dtf6zk522Qkk90aTDQX2h++S9Zqx6qj+ooLk13dKr8ffKwkD/BU6eq
         n6jEAa/yShrGmRD54pJV2L0FcuFBwpehvvpZjF/qilmETc8WNCQHK5tGDh8KaT9PHRnk
         oIdpmREoElx+QhuqIBsNzYDCxqUA7SEE43eeF0je2PhDuFJLiddd/01E2jrDkf9OEI3R
         Fu2MFCW8j3ikJwI8p0VDbuSOmfYuUw1DaKGXNqyJ+UoBS3xbFPWKX/1uFMNKuSdSJP1W
         /ZjQ==
X-Received: by 10.68.242.130 with SMTP id wq2mr4783708pbc.117.1445357483568;
        Tue, 20 Oct 2015 09:11:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:e1b1:e6e0:dc10:8032])
        by smtp.gmail.com with ESMTPSA id yq2sm4553614pbb.39.2015.10.20.09.11.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 09:11:22 -0700 (PDT)
In-Reply-To: <cbf2c2c2c137445ebb9e2c5f1012cb10@EXMBNJE8.ad.twosigma.com>
	(Enrique Tobis's message of "Tue, 20 Oct 2015 13:39:55 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279920>

Enrique Tobis <Enrique.Tobis@twosigma.com> writes:

> Hey!
>
> I'm really sorry to hear that.
>
> That change should enable more forms of authentication with your
> proxy, but it does cause libcurl to choose the one it finds most
> secure, according to the docs
> (http://curl.haxx.se/libcurl/c/CURLOPT_HTTPAUTH.html) What kinds of
> authentication does your proxy use?

Good line of thought.  The answer would reveal what non-working
authentication form the proxy claims to support is chosen because
libcurl considers more secure than the one the user wants to use.
I'd imagine that the next step after that would be to make the list
of authentication forms configurable so that the user can say "hey
my proxy claims to support this one but it does not work" to skip
it?

That sounds like a similar approach as what we did for SSL ciphers
in f6f2a9e4 (http: add support for specifying an SSL cipher list,
2015-05-08) where some people had problems with certain cipher the
server/client claimed to support when it was in fact broken.

Thanks.
