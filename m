X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Sat, 21 Jan 2006 18:31:04 +0000
Message-ID: <b0943d9e0601211031h2ef0a499s@mail.gmail.com>
References: <1137144291.20073.104.camel@dv>
	 <b0943d9e0601160018x206faf9ck@mail.gmail.com>
	 <1137517300.20556.26.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sat, 21 Jan 2006 18:31:19 +0000 (UTC)
Cc: git <git@vger.kernel.org>, Charles Lever <cel@citi.umich.edu>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mprb/lDxMPo9H2SuEaShWUZ2YHLD2xSwFPmfGmejIWKAvQzuKQwLtLh55Gw2nhFQ+jI2Vkfw175uYXKlv1WNUNIOkiByp/r/2VC+tdRn2i/kFiylGGkfO7pXNTw5pbyIbgwKpixTdnIw6aiJrXoeFiXzxK1i9W12OSTcHTgFjmc=
In-Reply-To: <1137517300.20556.26.camel@dv>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1F0NW4-0000cy-6U for gcvg-git@gmane.org; Sat, 21 Jan
 2006 19:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932230AbWAUSbI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 21 Jan 2006
 13:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWAUSbI
 (ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 13:31:08 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:12481 "EHLO
 xproxy.gmail.com") by vger.kernel.org with ESMTP id S932230AbWAUSbH convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006
 13:31:07 -0500
Received: by xproxy.gmail.com with SMTP id i30so457336wxd for
 <git@vger.kernel.org>; Sat, 21 Jan 2006 10:31:06 -0800 (PST)
Received: by 10.70.70.14 with SMTP id s14mr3766353wxa; Sat, 21 Jan 2006
 10:31:04 -0800 (PST)
Received: by 10.70.53.11 with HTTP; Sat, 21 Jan 2006 10:31:04 -0800 (PST)
To: Pavel Roskin <proski@gnu.org>
Sender: git-owner@vger.kernel.org

On 17/01/06, Pavel Roskin <proski@gnu.org> wrote:
> I was going to suggest that would be logical to run "stg refresh"
> implicitly if "stg new" is used on modified files.  But then I realized
> that it would be even better if future versions of StGIT allowed to
> refresh (i.e. add changes to) patches other that the current one.

I think that would be useful but not easy to implement. StGIT was
designed so that all operations happen on the top patch. The current
tree changes depend on the top patch and refreshing a different patch
with those changes would involve a three-way merge operation. This
merging can generate conflicts which are not relevant to the top tree
and they might even destroy the changes (depending on the merge
options).

The way I work is, again, through a dummy patch which can be folded
into the patch I want. This way I am sure that I still have the
changes in the dummy patch if I'm not happy with the merge. Maybe all
these could be done transparently and automatically remove the dummy
patch if conflicts exist.

--
