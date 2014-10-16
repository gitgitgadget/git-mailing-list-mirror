From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 00/11] Consolidate ref parsing code
Date: Fri, 17 Oct 2014 01:23:04 +0200
Message-ID: <54405358.3040803@alum.mit.edu>
References: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu> <xmqqwq7zspwm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 01:23:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeuO6-0004N1-9B
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 01:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbaJPXXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 19:23:12 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:57222 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750966AbaJPXXL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Oct 2014 19:23:11 -0400
X-AuditID: 1207440e-f79996d000007413-7b-5440535aa975
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id BE.4A.29715.A5350445; Thu, 16 Oct 2014 19:23:06 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1812.dip0.t-ipconnect.de [93.219.24.18])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s9GNN33x010618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 16 Oct 2014 19:23:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <xmqqwq7zspwm.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsUixO6iqBsV7BBisGGRpkXXlW4mi4beK8wW
	3VPeMlr8m1BjceZNI6MDq8fOWXfZPRZsKvW4eEnZY/EDL4/Pm+QCWKO4bZISS8qCM9Pz9O0S
	uDOaJjawFUzgrlj1+D1zA+Nzji5GTg4JAROJY/sPMELYYhIX7q1n62Lk4hASuMwo8ffFaSYI
	5xyTxN8fN8GqeAW0JQ63TmIFsVkEVCV6u/eygdhsAroSi3qamUBsUYEAiQ+dD6DqBSVOznzC
	AmKLCKhJTGw7xAIylFlgP6PEkl1zmbsYOTiEBawkVnwPBKkREiiS6Nz3mBEkzClgLbFiuSuI
	ySygLrF+nhBIBbOAvETz1tnMExgFZiFZMAuhahaSqgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz
	8lKLdI31cjNL9FJTSjcxQgKbbwdj+3qZQ4wCHIxKPLwawfYhQqyJZcWVuYcYJTmYlER5uTwd
	QoT4kvJTKjMSizPii0pzUosPMUpwMCuJ8D7XAMrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeW
	pGanphakFsFk1Tk4BK7s/xUuxZKXn5eqJMHLHgQ0Q7AoNT21Ii0zpwShkomDE2QPl5RIcWpe
	SmpRYmlJRjwoduOLgdELkuIBOkEMpJ23uCAxFygK0XqKUVFKnPdpIFBCACSRUZoHNxaWxF4x
	igM9LMwrDdLOA0yAcN2vgAYzAQ2eGGoLMrgkESEl1cC4Ocxwv87fnbe1li+TDyi5a1e54Ozd
	9yycUryOxsk/3ux1LFq049fpaufAeQbVLduLl3ypueb92lNyVVyv74WD5WkrT/J2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/16/2014 10:47 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This is a rif on Duy's oldish patch series [1]. I started reviewing
>> his patch series, but found that some of his patches did multiple
>> things, making it harder to review. I started pulling it apart into
>> smaller changes to aid my review, and I guess I got carried away :-/
> 
> Hmmm...
> 
> You are aware of another large change in flight in the same area,
> and after having reviewed that series a few times I was hoping that
> you would have a better understanding of how ready the other topic
> is.  And then I see this series that conflicts with that other
> topic.  Is this your way to say that the other topic is not quite
> ready?

No, not at all. To be honest, I thought that the changes in this patch
series were localized in an area different than Ronnie and Jonathan's
patches were touching, but stupidly I didn't check for conflicts. Sorry
about that.

There is nothing urgent in this patch series, so I suggest we just put
it back on ice and I will reroll after the dust has settled on
rs/ref-transactions. The conflicts shouldn't be super hard to resolve
(the series don't overlap much *conceptually*), but I'd rather not have
to do it multiple times.

Regarding rs/ref-transaction, I will reply on that thread.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
