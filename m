From: Adam Simpkins <simpkins@facebook.com>
Subject: Re: [PATCH] graph API: fix bug in graph_is_interesting()
Date: Wed, 19 Aug 2009 15:55:47 -0700
Message-ID: <20090819225547.GR8147@facebook.com>
References: <1250628954.114121983@192.168.1.201> <20090818211812.GL8147@facebook.com> <7vk5103chi.fsf@alter.siamese.dyndns.org> <20090819022918.GO8147@facebook.com> <20090819023433.GP8147@facebook.com> <7vhbw41g3f.fsf@alter.siamese.dyndns.org> <7v4os41frm.fsf@alter.siamese.dyndns.org>
Reply-To: Adam Simpkins <simpkins@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 00:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdu4u-00020X-Rn
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 00:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbZHSW4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 18:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbZHSW4D
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 18:56:03 -0400
Received: from mailout-snc1.facebook.com ([69.63.179.25]:57674 "EHLO
	mailout-snc1.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbZHSW4D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 18:56:03 -0400
Received: from mail.thefacebook.com (intlb01.snat.snc1.facebook.com [10.128.203.17] (may be forged))
	by pp01.snc1.tfbnw.net (8.14.1/8.14.1) with ESMTP id n7JMthiU029821
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Wed, 19 Aug 2009 15:55:43 -0700
Received: from simpkins (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.105) with Microsoft SMTP Server (TLS) id 8.1.393.1; Wed, 19 Aug
 2009 15:55:47 -0700
Received: from simpkins by simpkins with local (Exim 4.69)	(envelope-from
 <simpkins@facebook.com>)	id 1Mdu4J-0005VU-FT; Wed, 19 Aug 2009 15:55:47 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7v4os41frm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-08-19_15:2009-08-11,2009-08-19,2009-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0907200000 definitions=main-0908190184
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126586>

On Tue, Aug 18, 2009 at 11:25:49PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> >
> > When simplify_commit() logic (now called get_comit_action()) decides to
> > show this commit because revs->show_all was specified, we did not rewrite
> > its parents, but now we will?
> 
> That is, here is what I meant...
> 
> -	if (action == commit_show && revs->prune && revs->dense && want_ancestry(revs)) {
> +	if (action == commit_show &&
> +	    !revs->show_all &&
> +	    revs->prune && revs->dense && want_ancestry(revs)) {
> 
> We may want to add some tests to demonstrate the breakage this fix
> addresses.

Yes, you're right.  Thanks for catching that.  I'll submit a test case
that checks this scenario.

-- 
Adam Simpkins
simpkins@facebook.com
