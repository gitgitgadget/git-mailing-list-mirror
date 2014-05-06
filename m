From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] test doc: test_write_lines does not split its arguments
Date: Tue, 6 May 2014 21:20:51 +0300
Message-ID: <20140506182051.GA10333@redhat.com>
References: <1398622524-26207-1-git-send-email-mst@redhat.com>
 <1398622524-26207-2-git-send-email-mst@redhat.com>
 <20140505235143.GU9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 20:36:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whk0P-000625-8P
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 20:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbaEFSWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 14:22:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26347 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbaEFSWI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 14:22:08 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s46ILx3K015758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2014 14:22:00 -0400
Received: from redhat.com (ovpn-116-50.ams2.redhat.com [10.36.116.50])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s46ILvJw008016;
	Tue, 6 May 2014 14:21:57 -0400
Content-Disposition: inline
In-Reply-To: <20140505235143.GU9218@google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248208>

On Mon, May 05, 2014 at 04:51:43PM -0700, Jonathan Nieder wrote:
> test_write_lines carefully quotes its arguments as "$@", so
> 
> 	test_write_lines "a b" c
> 
> writes two lines as requested, not three.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Hi,
> 
> Michael S. Tsirkin wrote:
> 
> > +++ b/t/README
> > @@ -596,6 +596,28 @@ library for your script to use.
> > +	test_write_lines "a b c d e f g" >foo
> > +
> > +   Is a more compact equivalent of:
> > +	cat >foo <<-EOF
> > +	a
> > +	b
> [...]
> > +++ b/t/test-lib-functions.sh
> > @@ -717,6 +717,11 @@ test_ln_s_add () {
> >  	fi
> >  }
> >  
> > +# This function writes out its parameters, one per line
> > +test_write_lines () {
> > +	printf "%s\n" "$@"
> > +}
> 
> How about this patch?
> 
> Thanks,
> Jonathan
> 
>  t/README | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/t/README b/t/README
> index 2d6232f..8a9d499 100644
> --- a/t/README
> +++ b/t/README
> @@ -596,15 +596,14 @@ library for your script to use.
>  		...
>  	'
>  
> - - test_write_lines <text>
> + - test_write_lines <lines>
>  
> -   Split <text> to white-space separated words and write it out on standard
> -   output, one word per line.
> +   Write <lines> on standard output, one line per argument.
>     Useful to prepare multi-line files in a compact form.
>  
>     Example:
>  
> -	test_write_lines "a b c d e f g" >foo
> +	test_write_lines a b c d e f g >foo
>  
>     Is a more compact equivalent of:
>  	cat >foo <<-EOF
> -- 
> 1.9.1.423.g4596e3a
