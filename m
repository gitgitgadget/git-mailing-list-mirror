From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: Use get_sha1_committish instead of read_ref in init_notes()
Date: Wed, 17 Jun 2015 08:18:17 -0700
Message-ID: <xmqqsi9q4b46.fsf@gitster.dls.corp.google.com>
References: <1434503731-26414-1-git-send-email-mh@glandium.org>
	<xmqq1thb58i8.fsf@gitster.dls.corp.google.com>
	<20150617094036.GA536@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jun 17 17:18:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5F6j-0001xG-3K
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 17:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286AbbFQPSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 11:18:23 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36233 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756922AbbFQPSU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 11:18:20 -0400
Received: by igbiq7 with SMTP id iq7so69643747igb.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 08:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ScDWZIPd12e8J9Kh3OyCIXjoSKEgChAZ9NcvjMNn4GQ=;
        b=soCcyrgz4mUQ9MPepNWiGWcGarsl07WU+clp4rnom4dlNZHg//qn0pVOz9xIxLUTGn
         yRXbm7ev+eUb1A1OnKqPUNbVd00NX7h9jliP9C4P4nb6fzUyktcaKsZNzUbiOzqbWZci
         mt4KtH76kVFwYrMqXgEdFWHv+VeBp7Kwf2eqk5VOup35q4HcZbKlOcy6oJGC6dt91wp8
         tpr0HfP0ChgNCD8778W6ekjMPL47sFXwS21LUWVPHFY17HPyzjpEQX9mLo7oAFlzM3OL
         HxYFS8BZqsAIAfAN8/iOutajqM5OhMOmyNppbBEPHJ+oA2W+KQlpWxN7pohtRxPdO1Zw
         Lrsw==
X-Received: by 10.107.154.70 with SMTP id c67mr8802066ioe.22.1434554299409;
        Wed, 17 Jun 2015 08:18:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id d4sm2775718iod.17.2015.06.17.08.18.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 08:18:18 -0700 (PDT)
In-Reply-To: <20150617094036.GA536@glandium.org> (Mike Hommey's message of
	"Wed, 17 Jun 2015 18:40:36 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271855>

Mike Hommey <mh@glandium.org> writes:

> I'm tempted to make init_notes itself do the check, based on the value
> it is given for a "read_only" argument.

Yeah, that would be one sensible way to go after making sure that
everything goes thru this interface.

> On the other hand, some commands
> do their ref resolving themselves already.

Again, as long as they do not bypass the "read-only" safety you are
suggesting to add to init_notes(), that is OK.
