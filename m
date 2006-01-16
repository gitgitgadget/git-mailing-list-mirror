From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Mon, 16 Jan 2006 08:18:07 +0000
Message-ID: <b0943d9e0601160018x206faf9ck@mail.gmail.com>
References: <1137144291.20073.104.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>, Charles Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Jan 16 09:18:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyPZE-0006hF-Do
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 09:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWAPISJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 03:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWAPISJ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 03:18:09 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:32299 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750932AbWAPISH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 03:18:07 -0500
Received: by xproxy.gmail.com with SMTP id i30so858605wxd
        for <git@vger.kernel.org>; Mon, 16 Jan 2006 00:18:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=isH5g0a0qNloY9QoMiy1K/71RsDYOiZps6tuS93uPx76vTDAvemlii/aH9T7jD49e3yFCZ+vXD8zBPUNjOQIhR+dpj7Q8zJ4ufsRjVTTpCBZR6MZPU4V0MX+y5dBbHP8AaOtlsr3/oYBH87tsiKCI7gyEM9TMm5O0y6BOQMTKbQ=
Received: by 10.70.71.4 with SMTP id t4mr5100861wxa;
        Mon, 16 Jan 2006 00:18:07 -0800 (PST)
Received: by 10.70.53.11 with HTTP; Mon, 16 Jan 2006 00:18:07 -0800 (PST)
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1137144291.20073.104.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14728>

Hi Pavel,

On 13/01/06, Pavel Roskin <proski@gnu.org> wrote:
> Maybe I don't understand something in StGIT, but it seems strange that
> "stg new" creates empty patch by default and requires "--force" to
> create a non-empty patch.

The 'new' command would fail to create a new patch if there are
changes in the tree.

I also find myself using the '--force' option most of the time. Even
when I create a an empty patch, I use to run 'status' before. The
current implementation is closer to Quilt where, AFAIK, you first
create a new patch and use 'add' for every modified file. Since 'add'
has a different meaning in StGIT, it might also make sense to remove
the '--force' option.

> 1) "stg new --force" becomes "stg new" and "stg new" becomes "stg new
> --empty", i.e. empty files can only be created with the "--empty"
> switch.
> 2) "stg new --force" becomes "stg record" or something.
> 3) "stg new --force" becomes "stg new --record" or something.
> 4) "stg new" works both with and without modified files.

Regarding (1), the newly created patch is empty anyway, you would need
to run 'refresh' to add the modified patches to it ('stg series -e'
would show the empty patches prefixed with a 0).

Anyway, I would also prefer option 4. If there are no objections, I'll
modify StGIT accordingly. It would also be useful to have a wiki page
about StGIT vs. Quilt to show the main differences.

--
Catalin
