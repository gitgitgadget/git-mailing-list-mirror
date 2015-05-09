From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 2/3] sha1_name: get_sha1_with_context learns to
 follow symlinks
Date: Sat, 09 May 2015 16:02:46 -0400
Organization: Twitter
Message-ID: <1431201766.24139.1.camel@ubuntu>
References: <1431124726-22562-1-git-send-email-dturner@twopensource.com>
	 <1431124726-22562-2-git-send-email-dturner@twopensource.com>
	 <xmqq7fsiifcz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 22:02:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrAxa-0005xm-CL
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 22:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbbEIUCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 16:02:51 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36817 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbbEIUCt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2015 16:02:49 -0400
Received: by qgeb100 with SMTP id b100so51392584qge.3
        for <git@vger.kernel.org>; Sat, 09 May 2015 13:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=EmLHtX8kKStkG5KRp6ACgvIZnQFnhtSK/aycofsCEd4=;
        b=OHbuQodHrJu0s9yxXAQAMBFppxapveODGtonvFk89KWDNDI4pNUhTcTez4jkSY4r8u
         k2BNtKs5KwjJvmtv3bozmr3Q9OgBU75sikXgm2xyy8mUd9ojSILI7VYyx1OFKUDovXTY
         WK4wRajR9VhTRtNOVtVDCZ3KYIUzt4Y585IIve55dEVRcDKintQJhjLjpS4ckySC/1XL
         m6xcajHELpYZHXWb4iEPZo7ihaWmO9VGowjQULUDSl3LwPpXiBNDsFIL1oARPPRzKEfk
         rBw6oI39O5JS5eE4j2fNfrSmzDGr6OMNlHKgcldzgt88MIzSDGPHdsqlEJn4nGxllAU1
         ZD+g==
X-Gm-Message-State: ALoCoQno3I2pgfzOcb1vKJXkyuLVfiV1C4EgaDbsBbaBfMwdLX34pcPTGhvrBxFA8CQKV9olH4ja
X-Received: by 10.140.150.143 with SMTP id 137mr5222856qhw.0.1431201768879;
        Sat, 09 May 2015 13:02:48 -0700 (PDT)
Received: from [10.0.1.16] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id 8sm6443794qhs.5.2015.05.09.13.02.47
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Sat, 09 May 2015 13:02:48 -0700 (PDT)
In-Reply-To: <xmqq7fsiifcz.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268710>

On Fri, 2015-05-08 at 20:45 -0700, Junio C Hamano wrote:
> dturner@twopensource.com writes:
> 
> > From: David Turner <dturner@twitter.com>
> >
> > Wire up get_sha1_with_context to call get_tree_entry_follow_symlinks
> > when GET_SHA1_FOLLOW_SYMLINKS is passed in flags. G_S_FOLLOW_SYMLINKS
> > is incompatible with G_S_ONLY_TO_DIE because the diagnosis that
> > ONLY_TO_DIE triggers does not consider symlinks.
> 
> Is "does not consider" something fundamental, or it just happens to
> be that way right now?

It just happens to be that way right now.  It would require work
approximately equivalent to this patch series to fix.
