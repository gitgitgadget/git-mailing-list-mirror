From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: git-diff-files -z output
Date: Sun, 22 May 2005 19:32:43 +0200
Message-ID: <20050522173243.GA18500@cip.informatik.uni-erlangen.de>
References: <20050522170540.GO15178@cip.informatik.uni-erlangen.de> <7v3bsffadn.fsf@assigned-by-dhcp.cox.net> <20050522172737.GB17570@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 19:32:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZuIU-0002XD-Tu
	for gcvg-git@gmane.org; Sun, 22 May 2005 19:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVEVRcq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 13:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVEVRcq
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 13:32:46 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:39116 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261197AbVEVRco (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 13:32:44 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4MHWhS8018796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 22 May 2005 17:32:43 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4MHWhc9018795
	for git@vger.kernel.org; Sun, 22 May 2005 19:32:43 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050522172737.GB17570@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
this is better (it strips the colon from the first mode):

sub
process_git_diff_output
{
        my $str = shift || die("Need Input");

        my @in  = split("\0", $str);
        my @out = ();

        while (@in) {
                my @tmp = split(' ', shift(@in));
                $tmp[0] =~ s/^://g;
                push(@tmp, shift(@in), shift(@in));
                push(@out, [@tmp]);
        }

        return(@out);
}

	Thomas
