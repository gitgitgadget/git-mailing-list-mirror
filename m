From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH/RFC 2/6] remote-curl.c: fix variable shadowing
Date: Tue, 19 Apr 2016 15:14:31 -0400
Organization: Twitter
Message-ID: <1461093271.5540.110.camel@twopensource.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	 <1460747949-3514-3-git-send-email-dturner@twopensource.com>
	 <xmqqega26a01.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 21:14:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asb6c-0005qB-Ow
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 21:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbcDSTOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 15:14:34 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35542 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbcDSTOe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 15:14:34 -0400
Received: by mail-qg0-f41.google.com with SMTP id f74so13695595qge.2
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=zwk63p9Y7PheEw8byJTB7etefb9h56EWo63zpd/EhxM=;
        b=WrQ31R9e58C7uodRJ73x9mkjMCbPVer1tzi5ClDwrxrBBvRXDPgLkL1yh0VlB5/BfD
         J9dex8yv8aOxnhNd8A7gI0k3RH3XY1AI96DKv3WJzIzNgnx1Tl+oI5wcw6+Qmg+ZVZ/7
         kNhqd7Zk/3J13j2bjgcdJ+9MXWEJZ3kDjW7Wg21WKxMrh/ctdEB11pEdEKQdIvdAT8SN
         fjIEz2c4rSkYhcQObuh6/X3DTdKsJ93BiaPnFqd1979oqMiiz+wA9rsEhFlxaWCExogP
         F4hMQYhv2jSDy1XGqhhoLl+HUOIGhvtGPvo9JtRyHedR0kN80LX2sJaNj4AaHQx99JXn
         AQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=zwk63p9Y7PheEw8byJTB7etefb9h56EWo63zpd/EhxM=;
        b=ElmrgcIgoMr4aRw/27TaJT7NMly29zagt0tWYfXCX/eXWpO9yYuJQmQhBLIcsamZFN
         VwOZKEaFmgAh4wuNsip0+7rF20RC0GrQsVmX+yuqIuY2Y2jfIhwcT7RKwhUS1eZDVKBB
         jzrObFTtfmsUPhuxQMtg5QTMjQG6mSmNqLOS0cV/AUeCDK9zvqhwhnUxm1wpxV42Jckw
         3bErc3Q9EM6Ic+zlHAkY+sQPVqKd9aY0iH3Xi7SsaVQ22Z6sBPqwqYSewDxsZKZES3lP
         /8ds2CmM/hluEqMl50yXk5eOG29W8EUf9JY+PxZh8WjOVsmi1i9Dmq2FxontLuGDfWJC
         rnvQ==
X-Gm-Message-State: AOPr4FUCRdXP8O8q3RERnoItG22kDzW0kTypfP7TwWcEHIEms/G9LERmKxGx497vDbZ/TQ==
X-Received: by 10.140.36.231 with SMTP id p94mr5671805qgp.79.1461093273115;
        Tue, 19 Apr 2016 12:14:33 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm29626112qka.26.2016.04.19.12.14.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 12:14:32 -0700 (PDT)
In-Reply-To: <xmqqega26a01.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291911>

On Mon, 2016-04-18 at 11:35 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > The local variable 'options' was shadowing a global of the same
> > name.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> 
> OK.  In general, giving a longer and more descriptive name to the
> global would be a direction to lead to more readable code, though.

OK, will do that instead.
