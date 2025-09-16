Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58ED625
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035864; cv=none; b=kWouBMJWC1Cm+iqWSjx4c6y7PVSTdxQq1CFoRmdGsD0PFDlbEFPk60Zk12ZHE8jqy6nUphTsirGMA1e7L6lS23I3OS8KvgwBqPqxSIUiWJ9S7s3fYSlHuv+LVDUn8b1A/r7wYKf7/IlzbEJ6juuuFbnQRW5lp/UyStl/IKvFAhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035864; c=relaxed/simple;
	bh=NCjQ8bG2N3S7sknT7FeKOOJkuZGBir0iSFBR9xYxHQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4ygXF1ML6nd99Ur5KXg2SLB/YLGZHOc3+9W5B0DdzmmVlF1ak7rGMD7sxCwIUUq+mr7PGt5wlAuZrxUXHmjEXY40vqhT7Zun4aN0LU+7MWTkvW42LfbQEiodNeFisbRZD8TpQ5MNAsV7z1ZoQn8EyFhJk1u7X1mW3j4UPefBIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ke1wtBsB; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ke1wtBsB"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-31d6aa3e73fso3803054fac.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 08:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758035862; x=1758640662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/zkfaSi1/Gnn0IZWRrSkq/jh1yHroM7wm6yOsF+3Oc=;
        b=Ke1wtBsBYHh/K532WaL+89AlNdHsumqUc8NTOcsD0aVYu2InY5QU+9ehV5cCuxNVf+
         pVRGLJQxCiN8KcX9hysqoFdb1UFiTaU9ZaOHBy26ZcEnrEvUe46uyLxiHM7OIAfdRju5
         IxLSwQtAR2ucyn5RVUYy68qNC0dra32YviC+oLz0uWCPkhFrszKmeJ2aw5l52Tis6xk6
         1SzKiBBhnIkG0NG7uTfFBXgoz01die47S4i60Uoci9mVIiDYWv7PIHAjHx7bhEETn4Lh
         2kD1UUhqCR0kCzWcgs2dulhLwjr3Z1UjZCGk3+QfJp0ZqossNSloBqGvFhD95VYCy1oW
         qX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035862; x=1758640662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/zkfaSi1/Gnn0IZWRrSkq/jh1yHroM7wm6yOsF+3Oc=;
        b=CPc6BLbMc12b7Q4qSsELfzpmVG+rRLWj+ylXMGIbRA0A2dp2YKo83wxrI76RPPkw+K
         EjN21+RmweUrN3M8jz2pT9AMNeXlgtMhiq1h3aWrVgNkYPJrol+p8znkAEQdMgjQ9lrY
         w6M9/dwSItaM5CgPqF9FJYbYXJmtJ5dFLy7VzMkzKBdcvQv7hGp8utMFQ43sGqjUPu9V
         wzvxRB4NZSJ/06HY7Mfrt2w9JyYvaDX/fjFMayorD7IUIoXSqnHvogJpNZkN91jHuU9Q
         LmL40p3/aij5TE+jmw48xCJ7LMwDBmpnQabJbRJ4KDXfKpWrYWme7M4dTA4lSLgXD7Pm
         ZEQg==
X-Gm-Message-State: AOJu0YxBdu58uLvm+9nsTBIgxvnXeavapE6qvf6Jtq9NKYIFRGPbFo/D
	rYVLqaCwnZTEkBTwMBgCs9pRNCKPryGQ3CpOFzJqd5J0QElh1Yl1rmDh
X-Gm-Gg: ASbGncvH/CNb4NB5VVDMYqLfMn+MH6qrid6LhWtZsLNOjfrzMxoheJ1Gc2ZP65VJbCQ
	vPfPctSOQj0rsE9YUk0/HVyTMZP9oE4ZJXFYbg+xOoS8lqqMNac4D9a//YASOM0rdlEZ7jYUBqt
	lNMdvXWes682SOtg6Mu/BL0a5K7zY3jqyf5cZAGaC3fwvA7y2wuSs+txSdM3B52HbYBL3tddmN8
	aYmK0i3w7XcSJKsxQWHEbWJHtQGbWbbmMspNkV6I1nXY1aSNFiKBQUKDZXPIWwqwleH9YX88x2w
	UM9/ptHr9mq9QNNrIOmKyQXuzQ3UaJL2JQqU+BXwoigbWGkOgnpvWk2xtZpJ+ZJwETBDe2IO/oF
	wGgY/pBOxwM9LjM6M
X-Google-Smtp-Source: AGHT+IEP5IBhio9JzBQSSsSfl6jhShzNkxNf202LZ3PRv2jjozz3cpzll4bGbWBJhE+qsJNQkYQ8zQ==
X-Received: by 2002:a05:6871:588d:b0:32b:d4f0:46fd with SMTP id 586e51a60fabf-3345207a3cfmr1322328fac.7.1758035861564;
        Tue, 16 Sep 2025 08:17:41 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-32d35382f8asm4802099fac.19.2025.09.16.08.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:17:41 -0700 (PDT)
Date: Tue, 16 Sep 2025 10:17:40 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v2 2/6] builtin/update-index: end ODB transaction when
 --verbose is specified
Message-ID: <xvrq3xrmxnotzwyurnrxmxxq6aoclns3ywykoguenlw4a7euyl@7xys5dgoxpbv>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250915202956.3784935-1-jltobler@gmail.com>
 <20250915202956.3784935-3-jltobler@gmail.com>
 <CAOLa=ZS_H2CKvYy09Xd1GPqS9Bd5v_dZYiOLjZRbKN4fbYRbVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS_H2CKvYy09Xd1GPqS9Bd5v_dZYiOLjZRbKN4fbYRbVA@mail.gmail.com>

On 25/09/16 02:07AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> > +			/*
> > +			 * It is possible, though unlikely, that a caller could
> > +			 * use the verbose output to synchronize with addition
> > +			 * of objects to the object database. The current
> > +			 * implementation of ODB transactions leaves objects
> > +			 * invisible while a transaction is active, so end the
> > +			 * transaction here early before processing the next
> > +			 * update. All further updates are performed outside of
> > +			 * a transaction.
> > +			 */
> > +			if (transaction && verbose) {
> > +				end_odb_transaction(transaction);
> > +				transaction = NULL;
> > +			}
> > +
> 
> So with this change, we now have all objects updated before the
> `--verbose` flag updated via a single transaction. Updates after the
> `--verbose` flag will no longer use a transaction.
> 
> The older version would flush the transaction on every report, is there
> is any benefits to the new flow with regards to performance?

The older version would only flush transaction during a report if the
--verbose option is enabled. Object written without --verbose would not
be immediately flushed on report.

In this version we have functionally the same thing, but instead of
flushing the transaction every report, the transaction is ended and
subsequent object writes are written outside of a transaction instead.

I'll try to clarify this in the commit message.

-Justin
