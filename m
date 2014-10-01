From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH] git-prompt.sh: shorter equal upstream branch name
Date: Tue, 30 Sep 2014 23:54:32 -0400
Message-ID: <542B7AF8.6080501@bbn.com>
References: <1412091370-11727-1-git-send-email-jcarsique@nuxeo.com>	<542B1623.2070109@bbn.com> <xmqq7g0krb2p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: Julien Carsique <julien.carsique@gmail.com>, git@vger.kernel.org,
	=?windows-1252?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 06:21:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZBQF-0005jx-JG
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 06:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbaJAEVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 00:21:38 -0400
Received: from smtp.bbn.com ([128.33.1.81]:25944 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbaJAEVh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 00:21:37 -0400
X-Greylist: delayed 1617 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Oct 2014 00:21:37 EDT
Received: from socket.bbn.com ([192.1.120.102]:47970)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1XZB04-0002YA-Ky; Tue, 30 Sep 2014 23:54:48 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 5B6B0401AF
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <xmqq7g0krb2p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257691>

On 2014-09-30 18:35, Junio C Hamano wrote:
> Richard Hansen <rhansen@bbn.com> writes:
>>   * While this syntax works in both Bash and Zsh (assuming no
>>     pattern-special characters), my preference is to stick to POSIX[1]
>>     when possible.
> 
> Nah.  The existing script is full of bash-isms like local you
> suggested to add (and other constructs like shell arrays and [[ ]]
> tests, I suspect),

True.

> and there is no hope to "fix" them to stick to
> the bare-minimum POSIX,

I don't think it'd be hard to convert it to pure POSIX if there was a
desire to do so.  The biggest challenge would be 'local', which would
require subshells or uniquified prefixed global variables.  Both of
those are likely to make the code a bit grotesque.

> and there is no need to do so (isn't this
> bash-prompt script after all?)

It would be unwise to go to great lengths to avoid Bashisms, but I think
it would be smart to use POSIX syntax when it is easy to do so.  Rarely
is it hard or awkward to use POSIX syntax ('local' and arrays are two
major exceptions), so Bashisms like the ${//} expansion in this patch
are usually unnecessary divergences from a ubiquitous standard.  POSIX
is a stable foundation, and it's easy to get POSIX shell code to run
consistently on all POSIX-like shells.

One of these days I'll try converting git-prompt.sh to POSIX -- I'm
curious to see how bad it would be.

-Richard
