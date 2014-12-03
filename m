From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Disabling credential helper?
Date: Tue, 2 Dec 2014 16:59:53 -0800
Message-ID: <20141203005953.GB6527@google.com>
References: <20141203000310.GE90134@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 02:00:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvyIU-0001Fy-1O
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 02:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbaLCA75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 19:59:57 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:49270 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaLCA74 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 19:59:56 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so16031673igb.1
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 16:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AD8O2i0/dW0Xn4huW1qJVST9SJfm91M7yiMEvLuxKVk=;
        b=Yjrlh7+mtg3EgU6+Fxx4uwZc60GIqR4FyC6vUXKLtPFg4c9MDizOXZGfjFSXqg2YX8
         QZrFN6g+IbeFFNLdckbDMq9CCrhf4xC22WaQDj6913KgeF64xhZyxssW/Dxcn5BITCXj
         EHEgSSp9Uv2lEd5CWu7lDYDY8Kd2Rgz56ZVck5+0AK9cWTWRaUZnOn795ou8jiSWxeeC
         qtozgA7xeoXTqi2PD+1e95rFiU1D/zE/brU0p/eA9UJSGrREkPiSKTU5umi57n8Zf+4s
         Eb70G2vNeeOTLwCfHNpUxmouSxAdKZHwFJ15fl0pzNWw4CqGLoFELkMMpA7t+iN79hUH
         QzYA==
X-Received: by 10.42.199.68 with SMTP id er4mr5113531icb.38.1417568396072;
        Tue, 02 Dec 2014 16:59:56 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id n2sm1802744igp.16.2014.12.02.16.59.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 16:59:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203000310.GE90134@vauxhall.crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260609>

(+peff)
Hi,

brian m. carlson wrote:

> We've used GIT_ASKPASS=/bin/echo, which seems to solve the problem,
> although it's ugly and I'm concerned it might break in the future.  Is
> there a better way to do this?

That's a good question.  Before falling back to the askpass based
prompt, Git tries each credential helper matching the URL in turn, and
there doesn't seem to be an option to override that behavior and disable
credential helpers.

As long as you have no credential helpers configured, your GIT_ASKPASS
based approach should work fine.

But once you have helpers configured, you're potentially in trouble.
I'm wondering if we ought to provide an --no-credential-helpers option
to help with this.  (Or to go further and provide a way to unset
configuration items --- e.g., '-c "credential.*=unset"'.)

Thoughts?
Jonathan
