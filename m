From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@fzi.de>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Tue, 17 Apr 2012 02:31:00 +0200
Message-ID: <20120417003100.GB2299@goldbirke>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 02:31:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJwKA-0005zW-Mv
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 02:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918Ab2DQAbJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 20:31:09 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:57980 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754654Ab2DQAbH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 20:31:07 -0400
Received: from localhost6.localdomain6 (p5B130635.dip0.t-ipconnect.de [91.19.6.53])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MSTdP-1SizQl3Qs7-00TYU0; Tue, 17 Apr 2012 02:31:01 +0200
Content-Disposition: inline
In-Reply-To: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:fpgmZ6YYue3QitDVBAqguhKEtxc6IKy9Sgci2XHXT6o
 970H0B5FjNIVB+eO2Zzi+O1S6mJ6vZqjwEFPt4F7/CjNC3+G8i
 sm22pVwaVRUlPDQbCqkw79tCX9CFH5VDBLymmkgSz5+qI/XGtS
 PNWZmnxLFoaxPfxCNaZgrtjMMS3COkSiyalrY7SGNpa4hwDyMF
 LJhCNplmnbWto14FnGscQcxqNLGJHjD7rqvF083GInaN1/jBqp
 p2j5FnsVyiKHfHDjNAvKFI0acrVRqNgEiTrhu77b3OyJGVptmK
 //Lnw6qtNioQeVjqM764Gi/zKkspH+F3bgravYMD/C1tjeBq7I
 FGDrF0Ymt5HhDXVlBN08=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195727>

Hi,


I picked up Stephen Boyd's two-patch series[1] to use parse-options to
generate options for git commands, and the following test promply
failed (taken from 5c293a6b (tests: add initial bash completion tests,
2012-04-12)):

test_expect_success 'double dash "git checkout"' '
        sed -e "s/Z$//" >expected <<-\EOF &&
        --quiet Z
        --ours Z
        --theirs Z
        --track Z
        --no-track Z
        --merge Z
        --conflict=3D
        --orphan Z
        --patch Z
        EOF
        test_completion "git checkout --"
'

Not surprising, the completion script doesn't know about many 'git
checkout' long options.  So whenever 'git checkout' learns a new long
option, this list must be updated.  This won't be more work than the
update of the completion script, so this is probably OK.

But it got me thinking about what do we actually want to test here?
Whether the completion script returns the right long options in a
specific order upon 'git checkout --<TAB>'?  Or whether _git() works
properly and invokes the right command-specific completion function?
Or whether regular options get a trailing space while options
expecting an argument don't?  Or is this sort of an integration test
and basically all of the above?


[1] - http://thread.gmane.org/gmane.comp.version-control.git/195158/foc=
us=3D195158

Best,
G=E1bor
