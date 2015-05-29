From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/2] git-rebase -i: Add key word "drop" to remove a commit
Date: Fri, 29 May 2015 08:36:14 -0700
Message-ID: <xmqqwpzre6q9.fsf@gitster.dls.corp.google.com>
References: <20150529082650.055A4487BA@zm-smtpout-1.grenet.fr>
	<1416141686.132444.1432888411621.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git list <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Philip Oakley <philipoakley@iee.org>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 29 17:36:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyMKc-00057Z-Oe
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 17:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbbE2PgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 11:36:17 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:34102 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbbE2PgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 11:36:16 -0400
Received: by ieczm2 with SMTP id zm2so65714690iec.1
        for <git@vger.kernel.org>; Fri, 29 May 2015 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bY2g1wiYa66wTHXXbKrWiVypo9/fOTjFtf9lqHei8xk=;
        b=XbWx6FRhzrFtZkGqVMXQHbLkvMVsJ91mv75WRX5JXAwh+EieWH3e58DnDhQozVJaO7
         K1ipd0nYlmDAsC9zDhLyZsZ+/peqlx1eNe/NS4WBN2Crr0UXvpw8dZMrPue1yKgqxhMe
         erSs3njWhwPT6NgoLPYTtKIfvOMm4IJz68Z0/qx1Vwu8/+QMNLBp6eR/9mF3KJuvH9KI
         6TQaU4AgsXUEkqUYWDud1lOkW0wSIatD52CY0duG5+hv9lBo59lmevkhtkVP8tr05nki
         6MWrk3w7L3jR7kxREIP2o7DukRvRX7Ph2V7qHsaPqWjkxyj5BZzhs4wQSFxefRmrRfJk
         wOFg==
X-Received: by 10.107.131.141 with SMTP id n13mr10958102ioi.74.1432913776001;
        Fri, 29 May 2015 08:36:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id p4sm1732089igg.20.2015.05.29.08.36.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 08:36:15 -0700 (PDT)
In-Reply-To: <1416141686.132444.1432888411621.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Fri, 29 May 2015 10:33:31 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270244>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
writes:

> At first we wanted a clear indication about removing a commit in
> rebase -i. We didn't know about the noop command.
>  - 'noop' does the same thing as 'drop' but for the user deleting a
>    commit through 'noop' doesn't seem to be the proper way to use this
>    command. Moreover 'noop' is not documented (especially it is not
>    shown in the short help that is display in the editor during the
>    rebase -i)

As Matthieu said elsewhere during the discussion, 'noop' is merely
to ignore everything that follows (so 'noop stupid git' does not
mean "ignore commit identified by 'stupid git'") and the only reason
why it exists is as a hack to have a way to make a non-empty todo
list, because an empty todo list means "do not do anything, not even
rewinding to the onto commit".

As such, I actually think it is a mistake to consider 'noop' as
"drop _this_ commit"; the remainder of the line that begins with
'noop' does not name any commit.
