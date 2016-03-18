From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] merge: refuse to create too cool a merge by default
Date: Fri, 18 Mar 2016 18:23:56 -0400
Organization: Twitter
Message-ID: <1458339836.9385.29.camel@twopensource.com>
References: <xmqqshznpmfe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 23:24:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah2oV-0002vR-P2
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 23:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbcCRWYC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 18:24:02 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36508 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424AbcCRWX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 18:23:59 -0400
Received: by mail-qg0-f51.google.com with SMTP id u110so112360273qge.3
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 15:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=KGQoiOI75fVi/HapdRunvMCBe9PzB6cbzI2pssyN6tU=;
        b=NKH1Kqoe+JPdKDWFnTP5tWyYbyOUvloWRzSmtiEoWCmepxMdr17cFKY/9JJWRszw3g
         RANV85iLQu0Ly1XcRrRpobjFigKZyN7/xIqrflwy0N9bgP7EtQTb1zpGi2nXXErFiv5P
         qaTsa+BsYF6XOqguYKvbcCztn/FRFNWusZFSzoqkZ6cfHXAH+lqb/t+0Us1rEqReC+wj
         dt4mmZ9n3TnP+io3V5w4ix/d814YuyfzC+uCOprfMcdT5PFCRzMptjHu0zJGCwtbKYi1
         Es7h1fLcU7elWZbG04vbmwaSKok/uZkflXCP24l66RT/UX/ALmwjmAANrwyw1uSMO8Q+
         LsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=KGQoiOI75fVi/HapdRunvMCBe9PzB6cbzI2pssyN6tU=;
        b=U2rbMwNUPK5g9ZpAdwqNOuMJlEsccEDlWySnqSo9z6K25qXwrFLzM9dgx1vZ4y2NVd
         lwiCtETiEksLlyqGb6WgfUDKQfzFab64KGPb1pdaZthUjbPo1b6BC+nxNbu2Cfb+UyRr
         jG2Mjvd6o3rOUIbrFDdTWTkfKtDphcqbeIsB2i1rtfIb8JgQd4GPVPPnUpAWiQnIsXYw
         +u1WBQ1BvG63k1VIIKTAZH8XS0WDDkQkXqRyoYGOcGAWBlm/ISH2WYmPc0EWzJP9pAYx
         NZc8HS3kobXBvS5ckFyFYtAyMzDQxm7tlB09FiL/iWnqAgpqp7ytb2Q4NRzNDOWf6nDy
         vA+A==
X-Gm-Message-State: AD7BkJLUlkXCP4oG1soA7xJJcNaijEDZgQ6X+NYhlCnLRthydYVsr6dqKOMLhOsL+BhyzQ==
X-Received: by 10.141.2.11 with SMTP id e11mr27146834qhd.69.1458339838440;
        Fri, 18 Mar 2016 15:23:58 -0700 (PDT)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id e11sm6933688qkb.39.2016.03.18.15.23.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 15:23:57 -0700 (PDT)
In-Reply-To: <xmqqshznpmfe.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289262>

On Fri, 2016-03-18 at 13:21 -0700, Junio C Hamano wrote:
>  Many tests that are updated by this patch does the
> pass-through manually by turning:

Nit: Should be many tests ... do

Also, I didn't notice a test that shows that "cool" merges without
allow-unrelated-histories are forbidden.
