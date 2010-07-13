From: "Pickens, James E" <james.e.pickens@intel.com>
Subject: RE: [BUG] 'diff A...B' fails with multiple merge bases
Date: Mon, 12 Jul 2010 18:16:55 -0700
Message-ID: <3BA20DF9B35F384F8B7395B001EC3FB36D000E3D@azsmsx507.amr.corp.intel.com>
References: <3BA20DF9B35F384F8B7395B001EC3FB36CF674AE@azsmsx507.amr.corp.intel.com>
 <7vaapw8ehn.fsf@alter.siamese.dyndns.org>
 <7vocec6xlt.fsf@alter.siamese.dyndns.org>
 <7viq4k6xea.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 03:17:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYU7c-0003IY-FK
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 03:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab0GMBRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 21:17:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:58841 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754766Ab0GMBRO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 21:17:14 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 12 Jul 2010 18:15:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.55,191,1278313200"; 
   d="scan'208";a="817411195"
Received: from unknown (HELO azsmsx603.amr.corp.intel.com) ([10.2.161.23])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jul 2010 18:16:48 -0700
Received: from azsmsx507.amr.corp.intel.com ([10.2.121.87]) by
 azsmsx603.amr.corp.intel.com ([10.2.161.23]) with mapi; Mon, 12 Jul 2010
 18:16:56 -0700
Thread-Topic: [BUG] 'diff A...B' fails with multiple merge bases
Thread-Index: AcsiIezoYbkBmmb6Tt+BBCmrCk4GWQAA/lFQ
In-Reply-To: <7viq4k6xea.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150865>

Junio C Hamano <gitster@pobox.com> writes:
>> I prepared a patch to reject such a request when there are more than one
>> merge base (see below---it is against 1.6.4 maintenance track).  While I
>> think giving _one_ possible explanation of what you did since you forked
>> would be better than rejecting, which I'll try in a separate message, but
>> at the same time it may be misleading to give such an output without
>> telling the user that we chose one merge base at random to diff against
>> it.
>
>And this is the other one (not relative to the previous patch) that shows
>diff since one randomly chosen merge base.

Thanks for the detailed explanation and patches!

Personally I like this behavior better than erroring out when there are multiple
merge bases, even though the result is unpredictable.  We were using 'diff
A...B' in a script that users run to submit their changes to a continuous
integration server, to check whether they had any actual changes to submit.  In
that context, we don't care whether the output makes sense, we only care whether
there is any output.

The script has been changed to avoid using the A...B syntax now, so it's not a
big deal if you prefer to just error out in this situation.  But FWIW, this
patch also has the advantage that it makes the code match the existing
documentation... assuming that the randomly chosen merge base is the same one
that 'git merge-base' would print.

James
